//
//  ToursVC.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class ToursVC: BaseVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .darkContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func set(title: String) {
        setAttributed(title: title.withAttr(font: .boldSystemFont(ofSize: 20)))
    }
}
//MARK: - Actions -
private extension ToursVC {
    
}
//MARK: - Helpers -
private extension ToursVC {
    
}

