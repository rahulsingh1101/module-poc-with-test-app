//
//  RegisterViewModel.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import Foundation

protocol RegisterViewModelProtocol {
    func register(user: CreateUserRequest, completion:@escaping(User?)->Void)
}

final class RegisterViewModel: RegisterViewModelProtocol {
    func register(user: CreateUserRequest, completion: @escaping (User?) -> Void) {
        NetworkManager.shared.request(url: URL(string: create_user)!,
                                      method: .POST,
                                      body: BJSONEncoder<CreateUserRequest>().encode(user),
                                      headers: ["Content-Type": "application/json"],
                                      responseType: User.self) { result in
            switch result {
            case .success(let success):
                print("debug :: user created success ::\(success)")
                DispatchQueue.main.async {
                    completion(success)
                }
            case .failure(let failure):
                print("debug :: failed ::\(failure)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    
}
