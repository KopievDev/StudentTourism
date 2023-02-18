//
//  FavVC.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class FavVC: BaseVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .darkContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributed(title: "Избранное".withAttr(font: .boldSystemFont(ofSize: 20)))
    }
    
}
//MARK: - Actions -
private extension FavVC {
    
}
//MARK: - Helpers -
private extension FavVC {
    
}

