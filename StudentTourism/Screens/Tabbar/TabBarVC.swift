//
//  TabBar.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

final class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    var roundedShadowV = UIView(frame: .zero)

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        delegate = self
        let mainVC = MainVC.instantiate()!
        mainVC.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.mainTab.image, tag: 0)
        
        let favVC = FavVC.instantiate()!
        favVC.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.favTab.image, tag: 1)
        
        let bookVC = MainVC.instantiate()!
        bookVC.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.bookTab.image, tag: 2)
        
        let notifyVC = MainVC.instantiate()!
        notifyVC.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.notifyTab.image, tag: 3)
        
        let profileVC = MainVC.instantiate()!
        profileVC.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.profileTab.image, tag: 4)
        
        viewControllers = [ UINavigationController(rootViewController: mainVC),
                            UINavigationController(rootViewController: favVC),
                            UINavigationController(rootViewController: bookVC),
                            UINavigationController(rootViewController: notifyVC),
                            UINavigationController(rootViewController: profileVC)]

        selectedIndex = 0
        tabBar.unselectedItemTintColor = Asset.Colors.sGray.color
        tabBar.tintColor = Asset.Colors.sGreen.color
        tabBar.backgroundColor = Asset.Colors.sSecondary.color
        tabBar.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBar.cornerRadius = 16
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 40
        tabBar.itemWidth = 58
    }
    

    override func viewDidLayoutSubviews() {
        let newTabBarHeight = tabBar.frame.size.height + 12
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        tabBar.frame = newFrame
        
        tabBar.items?.forEach({
            $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
        })
        
        addRoundedViewWithShadow()
    }
    
    func getIndexOfController<T: UIViewController>(vc: T.Type) -> Int? {
        for (i, controller) in (viewControllers ?? []).enumerated() {
            if let nc = controller as? UINavigationController, nc.viewControllers.first is T {
                return i
            }
        }
        return nil
    }
        
    private func addRoundedViewWithShadow() {
        roundedShadowV.frame = tabBar.frame
        
        roundedShadowV.backgroundColor = Asset.Colors.sBackground.color
        roundedShadowV.layer.cornerRadius = 16
        roundedShadowV.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        roundedShadowV.layer.masksToBounds = false
        roundedShadowV.layer.shadowColor = Asset.Colors.sBlack.color.cgColor
        roundedShadowV.layer.shadowOffset = CGSize(width: 0, height: -2)
        roundedShadowV.layer.shadowOpacity = 0.2
        roundedShadowV.layer.shadowRadius = 10
        
        view.addSubview(roundedShadowV)
        view.bringSubviewToFront(tabBar)
    }
    
    func set(hidden: Bool) {
        UIView.animate(withDuration: 0.2) { [self] in
            roundedShadowV.isHidden = hidden
            tabBar.isHidden = hidden
        }
    }
}


