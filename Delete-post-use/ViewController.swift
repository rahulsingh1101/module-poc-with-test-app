//
//  ViewController.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private var viewModel: LoginViewModelProtocol!
    var onLoginSuccess: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(apiService: APIService())
        
        emailTextField.text = "rks@gmail.com"
        passwordTextField.text = "1234"
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        viewModel.loginUser(user: .init(email: emailTextField.text ?? "rkssingh566@gmail.com",
                                        password: passwordTextField.text ?? "0987667890")) {[weak self] status in
            guard let self else { return }
            print("debug :: login status ::\(status)")
            if status {
                onLoginSuccess?()
            }
        }
    }
    
    @IBAction func createUserAction(_ sender: UIButton) {
        NavigationHelper.navigate(to: RegisterUserController.self, from: self, identifier: RegisterUserController.className) { modal in
            print("debug :: the returned modal is ::\(modal)")
            self.emailTextField.text = (modal as? CreateUserResponse)?.email
        }
    }
}
