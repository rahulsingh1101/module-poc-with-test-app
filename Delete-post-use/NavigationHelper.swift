//
//  NavigationHelper.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import UIKit

protocol Transferable: UIViewController {
    associatedtype ModelType
    var onCompletion: ((ModelType) -> Void)? { get set }
}

class NavigationHelper {
    /// Navigates to a view controller by storyboard ID
    /// - Parameters:
    ///   - storyboardName: Name of the storyboard (e.g., "Main")
    ///   - identifier: Storyboard ID of the view controller
    ///   - from: The current UIViewController
    ///   - presentationStyle: .push (default) or .present
    static func navigate<T: UIViewController>(
        to type: T.Type,
        from currentVC: UIViewController,
        storyboardName: String = "Main",
        identifier: String,
        presentationStyle: PresentationStyle = .push,
        handler:((_ modal: Any)->Void)?
    ) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            print("❌ Failed to instantiate view controller with identifier \(identifier)")
            return
        }
        
        if let destinationVC = destinationVC as? (any Transferable) {
            configureCallback(for: destinationVC) { modal in
                handler?(modal)
            }
        }
        
        switch presentationStyle {
        case .push:
            if let nav = currentVC.navigationController {
                nav.pushViewController(destinationVC, animated: true)
            } else {
                print("⚠️ No navigationController found. Falling back to modal presentation.")
                currentVC.present(destinationVC, animated: true)
            }
        case .present:
            currentVC.present(destinationVC, animated: true)
        }
    }
    
    // This method is added because Transferable type is using associatedValue which need to be defined later while implementing the protocol
    private class func configureCallback<T: Transferable>(for controller: T, with handler: @escaping (T.ModelType) -> Void) {
        controller.onCompletion = handler
    }

    enum PresentationStyle {
        case push
        case present
    }
}
