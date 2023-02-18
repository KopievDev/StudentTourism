//
//  AppController.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

protocol AppControllerProtocol {
    func setup()
}

final class AppController {
    
    weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
}

extension AppController: AppControllerProtocol {
    func setup() {
        setupAppearance()
        setupInitialViewController()
    }
    
    static func present(vc: UIViewController) { UIApplication.topViewController()?.present(vc, animated: true) }
    
    static func push(vc: UIViewController) { UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true) }
    
    static func takeRoot(vc: UIViewController) {
        guard let window = UIApplication.shared.windows.first else {return}
        window.rootViewController = vc
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options) {}
    }
    
    static func setOrientation(mask: UIInterfaceOrientationMask = .all ) {
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = mask
    }
}

// MARK: Private
private extension AppController {
    func setupAppearance() {
//        UIBarButtonItem.appearance().tintColor = .fDarkGray
//        UITextField.appearance().tintColor = .fDarkGray
//        UITextView.appearance().tintColor = .fDarkGray
    }
    
    // MARK: - Initial screen
    func setupInitialViewController() {
        window?.rootViewController = UINavigationController(rootViewController:TabBarVC())
        window?.makeKeyAndVisible()
    }
}

public extension UIWindow {
    /// SwifterSwift: Switch current root view controller with a new view controller.
    ///
    /// - Parameters:
    ///   - viewController: new view controller.
    ///   - animated: set to true to animate view controller change (default is true).
    ///   - duration: animation duration in seconds (default is 0.5).
    ///   - options: animation options (default is .transitionFlipFromRight).
    ///   - completion: optional completion handler called after view controller is changed.
    func switchRootViewController(
        to viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.5,
        options: UIView.AnimationOptions = .transitionFlipFromRight,
        _ completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            completion?()
            return
        }

        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
}
