//
//  BookVC.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class BookVC: BaseVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributed(title: "Брони".withAttr(font: .boldSystemFont(ofSize: 20)))
    }
    
}
//MARK: - Actions -
private extension BookVC {
    
}
//MARK: - Helpers -
private extension BookVC {
    
}

