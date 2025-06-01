//
//  UserViewModel.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import Foundation

protocol LoginViewModelProtocol {
    init(apiService: APIServiceProtocol)
    func loginUser(user: LoginRequest, completion:@escaping(_ status: Bool)->Void)
    func fetchUserDetails()
}

final class LoginViewModel: LoginViewModelProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func loginUser(user: LoginRequest, completion:@escaping (Bool) -> Void) {
        callLoginApi(user: user, completion: completion)
    }
    
    func fetchUserDetails() {
        
    }
    
    private func callLoginApi(user: LoginRequest, completion:@escaping(Bool) -> Void) {
        apiService.request(
            url: login_user,
            method: .POST,
            body: user,
            headers: [:],
            success:{ (response: LoginResponse) in
                print("✅ LoginModel: \(response)")
                AuthManager().saveToken(response.accessToken)
                completion(true)
            }, failure: { (error: RegistrationError) in
                print("❌ RegistrationError: \(error)")
                completion(false)
            }, decodingFailed: { error in
                print("💥 Decoding/Network Error: \(error)")
                completion(false)
            }
        )
    }
}
