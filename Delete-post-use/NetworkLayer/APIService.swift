//
//  APIService.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 01/06/25.
//

import Foundation

protocol APIServiceProtocol {
    func request<S: Decodable, F: Decodable>(
        url: String,
        method: HTTPMethod,
        body: Encodable?,
        headers: [String: String]?,
        success: @escaping (S) -> Void,
        failure: @escaping (F) -> Void,
        decodingFailed: @escaping (ApiError) -> Void
    )
}

final class APIService: APIServiceProtocol {
    private let httpClient: HTTPClientProtocol = HTTPClient()
    
    func request<S: Decodable, F: Decodable>(
        url: String,
        method: HTTPMethod,
        body: Encodable?,
        headers: [String: String]?,
        success: @escaping (S) -> Void,
        failure: @escaping (F) -> Void,
        decodingFailed: @escaping (ApiError) -> Void
    ) {
        guard let url = URL(string: url) else {
            decodingFailed(.invalid_response)
            return
        }

        httpClient.performRequest(url: url, method: method, body: body, headers: headers) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()

                // Try decoding to Success type
                if let successResponse = try? decoder.decode(S.self, from: data) {
                    DispatchQueue.main.async {
                        success(successResponse)
                    }
                    return
                }

                // Try decoding to Failure type
                if let failureResponse = try? decoder.decode(F.self, from: data) {
                    DispatchQueue.main.async {
                        failure(failureResponse)
                    }
                    return
                }

                // Neither matched
                DispatchQueue.main.async {
                    decodingFailed(.decodingError("Unable to decode as either Success or Failure model"))
                }

            case .failure(let apiError):
                DispatchQueue.main.async {
                    decodingFailed(apiError)
                }
            }
        }
    }
}
