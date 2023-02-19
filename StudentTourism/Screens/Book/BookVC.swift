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
        setNeedsStatusBarAppearanceUpdate()
        setAttributed(title: "Брони".withAttr(font: .boldSystemFont(ofSize: 20)))
    }
    
}
//MARK: - Actions -
private extension BookVC {
    @IBAction func didTapTour(button: UIButton) {
        Router.showVC(type: TourViewVC.self)
    }
}
//MARK: - Helpers -
private extension BookVC {
    
}

