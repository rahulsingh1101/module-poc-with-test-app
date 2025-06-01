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
    private var viewModel: UserViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserViewModel()
        
        emailTextField.text = "rks@gmail.com"
        passwordTextField.text = "1234"
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        viewModel.loginUser(user: .init(email: emailTextField.text ?? "rkssingh566@gmail.com",
                                        password: passwordTextField.text ?? "0987667890")) { status in
            print("debug :: login status ::\(status)")
        }
    }
    
    @IBAction func createUserAction(_ sender: UIButton) {
        NavigationHelper.navigate(to: RegisterUserController.self, from: self, identifier: RegisterUserController.className) { modal in
            print("debug :: the returned modal is ::\(modal)")
        }
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
