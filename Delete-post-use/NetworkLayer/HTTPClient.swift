//
//  HTTPClient.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 01/06/25.
//

import UIKit

protocol HTTPClientProtocol {
    func performRequest(
        url: URL,
        method: HTTPMethod,
        body: Encodable?,
        headers: [String: String]?,
        completion: @escaping (Result<Data, ApiError>) -> Void
    )
}

final class HTTPClient: HTTPClientProtocol {
    func performRequest(
        url: URL,
        method: HTTPMethod,
        body: Encodable?,
        headers: [String: String]?,
        completion: @escaping (Result<Data, ApiError>) -> Void
    ) {
        var request = URLRequest(url: url)
        print("debug :: url ::\(url)")
        request.httpMethod = method.rawValue
        if let body {
            print("debug :: body ::\(body)")
            let jsonData = try? JSONEncoder().encode(body)
            request.httpBody = jsonData
        }
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                let err = ApiError.api_failure_reason(error.localizedDescription)
                completion(.failure(err))
                return
            }
            
            guard response is HTTPURLResponse else {
                completion(.failure(ApiError.invalid_response))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            if let string = String(data: data, encoding: .utf8) {
                print("debug :: data ::\(string)")
            }
            completion(.success(data))
        }
        
        task.resume()
    }
}
