//
//  ProfileVC.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class ProfileVC: BaseVC {
    
    override var withNavigationBar: Bool { false }
    override var preferredStatusBarStyle: UIStatusBarStyle { .darkContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
//MARK: - Actions -
private extension ProfileVC {
    @IBAction func didTapOwnData(button: UIButton) {
        Haptic.selection()
    }
    
    @IBAction func didTapLanguage(button: UIButton) {
        Haptic.selection()
    }
    
    @IBAction func didTapPay(button: UIButton) {
        Haptic.selection()
    }
    
    @IBAction func didTapSciense(button: UIButton) {
        Haptic.selection()
    }
    
    @IBAction func didTapEvents(button: UIButton) {
        Haptic.selection()
    }
    
    @IBAction func didTapCup(button: UIButton) {
        Haptic.selection()
        Router.showVC(type: CupVC.self)
    }
    
}
//MARK: - Helpers -
private extension ProfileVC {
    
}

