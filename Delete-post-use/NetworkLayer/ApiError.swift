//
//  ApiError.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 01/06/25.
//

import Foundation

enum ApiError: Error {
    case invalid_response
    case noData
    case api_failure_reason(String)
    case no_models_matched
    case decodingError(String)
}

//struct DecodingError: Error {
//    static let model_not_found = (statusCode:404, message:"model not found", domain: "")
//}
