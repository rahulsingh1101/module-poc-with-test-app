//
//  ViewControllerFactory.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 01/06/25.
//

import UIKit

extension UIViewController {
    static func load<T: UIViewController>(identifier: String, from storyboardName: String = "Main") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("❌ ViewController with identifier \(identifier) not found in \(storyboardName) storyboard.")
        }
        return viewController
    }
}
