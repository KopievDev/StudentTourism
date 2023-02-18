//
//  UIAplication.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

extension UIApplication {
    
    class func topViewController() -> UIViewController? {
        
        if var vc = UIApplication.shared.windows.first?.rootViewController {
            
            if vc is UITabBarController{
                vc = (vc as! UITabBarController).selectedViewController!
            }
            
            if vc is UINavigationController{
                vc = (vc as! UINavigationController).topViewController!
            }
            
            while ((vc.presentedViewController) != nil &&
                (String(describing: type(of: vc.presentedViewController!)) != "SFSafariViewController") &&
                (String(describing: type(of: vc.presentedViewController!)) != "UIAlertController")) {
                    vc = vc.presentedViewController!
                    if vc is UINavigationController{
                        vc = (vc as! UINavigationController).topViewController!
                    }
            }
            
            return vc
            
        } else {
            return nil
        }
        
    }
}

enum Haptic {
    
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: style)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    static func selection() {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    static func notification(_ style:UINotificationFeedbackGenerator.FeedbackType) {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        notificationFeedbackGenerator.notificationOccurred(style)
    }
}
