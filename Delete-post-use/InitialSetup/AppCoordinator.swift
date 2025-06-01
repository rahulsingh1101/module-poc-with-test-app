//
//  AppCoordinator.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 01/06/25.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let authToken = AuthManager(tokenKey: "auth_token")
        if let token = authToken.getToken() {
            showLandingScreen()
        } else {
            showLoginScreen()
        }
    }
    
    private func showLoginScreen() {
        let loginVC: ViewController = .load(identifier: ViewController.className)
        loginVC.onLoginSuccess = { [weak self] in
            self?.showLandingScreen()
        }
        window.rootViewController = UINavigationController(rootViewController: loginVC)
        window.makeKeyAndVisible()
    }
    
    private func showLandingScreen() {
        let landingVC: LandingViewController = .load(identifier: LandingViewController.className)
        landingVC.onLogout = {[weak self] in
            self?.showLoginScreen()
        }
        window.rootViewController = UINavigationController(rootViewController: landingVC)
        window.makeKeyAndVisible()
    }
}
