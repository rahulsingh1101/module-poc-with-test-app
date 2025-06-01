//
//  RegisterUserController.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import UIKit

//typealias CompletionHandler = () -> Void

final class RegisterUserController: UIViewController, Transferable {
    var onCompletion: ((User) -> Void)?
    typealias ModelType = User
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    private var viewModel: RegisterViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel = RegisterViewModel()
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        viewModel.register(user: .init(username: userNameField.text ?? "", email: emailField.text ?? "", password: passwordField.text ?? "")) { status in
            if let status {
                self.onCompletion?(status)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
