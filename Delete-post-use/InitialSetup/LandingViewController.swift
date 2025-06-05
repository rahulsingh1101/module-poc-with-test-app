//
//  LandingViewController.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 01/06/25.
//

import UIKit
import NetworkModule

final class LandingViewController: UIViewController {
    @IBOutlet weak var infoView: UITextView!
    var onLogout: (()->Void)?
    var user: User?
    private let viewModel: LandingViewModelProtocol = LandingViewModel(apiService: NetworkFactory.makeService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = "Landing Screen"

        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutButton
        viewModel.getUserDetails {[weak self] user in
            guard let self else { return }
            infoView.text = "\(user.id) \n \(user.username) \n \(user.email)"
        }
    }

    @objc private func logout() {
        AuthManager().deleteToken()
        onLogout?()
    }
}
