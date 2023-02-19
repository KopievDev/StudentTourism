//
//  BookVC.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class CupView: TableView {
    
    override func customizeUI() {
        cells = [Cell(reuseId: "NotifyCell"), Cell(reuseId: "NotifyCell"), Cell(reuseId: "NotifyCell"), Cell(reuseId: "NotifyCell"), Cell(reuseId: "NotifyCell")]
    }
    
    override func render() {
        
    }
}

