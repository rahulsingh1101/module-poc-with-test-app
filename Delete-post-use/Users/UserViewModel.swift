//
//  UserViewModel.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import Foundation

protocol UserViewModelProtocol {
    func loginUser(user: LoginRequest, completion:@escaping(_ status: Bool)->Void)
    func fetchUserDetails()
}

final class UserViewModel: UserViewModelProtocol {
    func loginUser(user: LoginRequest, completion:@escaping (Bool) -> Void) {
        callTheApi(completion: completion)
    }
    
    func fetchUserDetails() {
        
    }
    
    private func callTheApi(completion:@escaping(Bool) -> Void) {
//        viewModel.loginUser(user: .init(email: emailTextField.text ?? "rkssingh566@gmail.com",
//                                        password: passwordTextField.text ?? "0987667890"))
//        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoic3R1dGkiLCJlbWFpbCI6InN0dXRpQGdtYWlsLmNvbSIsImlkIjoiNjgzOTk1YjlmZjYyMWRkMWY1ODllMDA2In0sImlhdCI6MTc0ODY3NzcyNCwiZXhwIjoxNzQ4ODA5NzI0fQ.Bfs581_8tT2RQE3rB-akOPyn44TddzB2o2Am7907a4A"

        NetworkManager.shared.request(url: URL(string: login_user)!,
                                      method: .GET,
                                      body: nil,
                                      headers: ["Content-Type": "application/json"],
                                      responseType: User.self) { result in
            switch result {
            case .success(let success):
                print("debug :: value ::\(success)")
                completion(true)
            case .failure(let failure):
                print("debug :: failure ::\(failure)")
                break
            }
        }
    }
}
