//
//  CupVC.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class CupVC: BaseVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setAttributed(title: "Достижения".withAttr(font: .boldSystemFont(ofSize: 20)))
    }
    
}
//MARK: - Actions -
private extension CupVC {

}
//MARK: - Helpers -
private extension CupVC {
    
}

