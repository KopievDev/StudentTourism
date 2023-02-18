//
//  ProfileVC.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class TourViewVC: BaseVC {
    
    override var withNavigationBar: Bool { false }
    override var preferredStatusBarStyle: UIStatusBarStyle { .darkContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (tabBarController as? TabBarVC)?.set(hidden: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (tabBarController as? TabBarVC)?.set(hidden: false)
    }
    
}
//MARK: - Actions -
private extension TourViewVC {
    
}
//MARK: - Helpers -
private extension TourViewVC {
    
}

