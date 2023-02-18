//
//  Storyboarded.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> UIViewController?
    static func instantiateWithNav() -> UIViewController?
    static var storyboardName: String {get}
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        return storyboard.instantiateInitialViewController() as? Self
    }
    
    static func instantiate<T: Storyboarded>() -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        return storyboard.instantiateInitialViewController() as? T
    }
    
    
    static func instantiateWithNav() -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        let navVc =  storyboard.instantiateInitialViewController() as? UINavigationController
        return navVc?.viewControllers.first as? Self
    }

    static var storyboardName: String {
        String(describing: Self.self).hasSuffix("VC") ? (String(describing: Self.self) as NSString).replacingOccurrences(of: "VC", with: "") : String(describing: Self.self)
    }
}

extension BaseVC: Storyboarded {}

struct Router {
    
    enum Modal { case fullScreen, modal }
    enum PresentType { case present(Modal), push }
    
    @discardableResult
    static func showVC<VC: UIViewController>(type: VC.Type,
                                             with rootVC: UIViewController = UIApplication.topViewController()!,
                                             presentType: PresentType = .push,
                                             configure: ((VC) -> Void) = { _ in }) -> VC where VC: Storyboarded {
        let vc = VC.instantiate() as! VC
        present(vc: vc, with: rootVC, presentType: presentType, configure: configure)
        return vc
    }
    
    @discardableResult
    static func showVC<VC: UIViewController>(type: VC.Type,
                                             with rootVC: UIViewController = UIApplication.topViewController()!,
                                             presentType: PresentType = .push,
                                             configure: ((VC) -> Void) = { _ in }) -> VC {
        let vc = VC()
        present(vc: vc, with: rootVC, presentType: presentType, configure: configure)
        return vc
    }
    
    private static func present<VC: UIViewController>(vc: VC,
                                                      with rootVC: UIViewController,
                                                      presentType: PresentType,
                                                      configure: ((VC) -> Void) = { _ in }) {
        configure(vc)
        switch presentType {
        case .present(let modal):
            if case .fullScreen = modal { vc.modalPresentationStyle = .fullScreen }
            rootVC.present(vc, animated: true)
        case .push:
            if let nc = rootVC as? UINavigationController? {
                nc?.pushViewController(vc, animated: true)
            } else {
                rootVC.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
