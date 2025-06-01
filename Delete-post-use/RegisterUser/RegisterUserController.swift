//
//  RegisterUserController.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import UIKit

final class RegisterUserController: UIViewController, Transferable {
    var onCompletion: ((CreateUserResponse) -> Void)?
    typealias ModelType = CreateUserResponse
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    private var viewModel: RegisterViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel = RegisterViewModel(apiService: APIService())
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        viewModel.register(user: CreateUserRequest(
            username: userNameField.text ?? "",
            email: emailField.text ?? "",
            password: passwordField.text ?? ""
        )) { result in
            switch result {
            case .success(let user):
                if let value = user.success {
                    self.onCompletion?(value)
                    self.navigationController?.popViewController(animated: true)
                } else if let value = user.failure {
                    print("debug :: user controller error :: \(value)")
                } else {
                    fatalError("This is wrong")
                }
            case .failure(let failure):
                print("debug :: user controller failure :: \(failure)")
            }
        }
    }
}
