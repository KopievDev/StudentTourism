//
//  WebVC.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 19.02.2023.
//

import UIKit

class WebVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributed(title: "Оплата".withAttr())
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { Loader.hide() }
    }
    
}
//MARK: - Actions -
private extension WebVC {
    
}
//MARK: - Helpers -
private extension WebVC {
    
}

