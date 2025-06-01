//
//  RegisterViewModel.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import Foundation

protocol RegisterViewModelProtocol {
    // After registration completes, completion will return the created user or some error
    func register(user: CreateUserRequest, completion:@escaping(Result<(success: CreateUserResponse?, failure: RegistrationError?), UserRegistrationError>)->Void)
    init(apiService: APIServiceProtocol)
}

final class RegisterViewModel: RegisterViewModelProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func register(user: CreateUserRequest, completion: @escaping (Result<(success: CreateUserResponse?, failure: RegistrationError?), UserRegistrationError>) -> Void) {
        
        apiService.request(
            url: create_user,
            method: .POST,
            body: user,
            headers: nil,
            success: { (response: CreateUserResponse) in
                print("✅ CreateUserResponse: \(response)")
                completion(.success((response, nil)))
            },
            failure: { (error: RegistrationError) in
                print("❌ RegistrationError: \(error)")
                completion(.success((nil, error)))
            },
            decodingFailed: { error in
                print("💥 Decoding/Network Error: \(error)")
                completion(.failure(.unknown))
            }
        )
    }
    
    
}
