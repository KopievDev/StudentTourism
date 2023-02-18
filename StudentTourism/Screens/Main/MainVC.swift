//
//  ViewController.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class MainVC: BaseVC {
    
    override var withNavigationBar: Bool { false }
    override var preferredStatusBarStyle: UIStatusBarStyle { .darkContent }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
//MARK: - Actions -
private extension MainVC {
    @IBAction func didTapFilters(button: UIButton) {
        Router.showVC(type: FiltersVC.self)
    }
    
    @IBAction func didTapTour(button: UIButton) {
        Router.showVC(type: ToursVC.self) { vc in
            vc.set(title: "Беги к холмам")
        }

    }
}
//MARK: - Helpers -
private extension MainVC {
    
}

