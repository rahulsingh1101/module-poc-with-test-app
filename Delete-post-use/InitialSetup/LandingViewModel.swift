//
//  LandingViewModel.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 01/06/25.
//

import Foundation

protocol LandingViewModelProtocol {
    init(apiService: APIServiceProtocol)
    func getUserDetails(completion:@escaping(User)->Void)
}

final class LandingViewModel: LandingViewModelProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func getUserDetails(completion:@escaping(User)->Void) {
        let authManager = AuthManager()
        let token = authManager.getToken() ?? ""
        self.apiService.request(
            url: current_user,
            method: .GET,
            body: nil,
            headers: ["Authorization": "Bearer \(token)"],
            success: { (response: User) in
                print("✅ User Details: \(response)")
                completion(response)
            },
            failure: { (error: RegistrationError) in
                print("❌ RegistrationError: \(error)")
                authManager.deleteToken()
            },
            decodingFailed: { error in
                print("💥 Decoding/Network Error: \(error)")
                authManager.deleteToken()
            }
        )
    }
}
