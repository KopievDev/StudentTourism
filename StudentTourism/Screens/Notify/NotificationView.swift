//
//  NotificationView.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class NotificationView: TableView {
    
    override func customizeUI() {
        cells = [Cell(reuseId: "NotifyCell"), Cell(reuseId: "NotifyCell"), Cell(reuseId: "NotifyCell"), Cell(reuseId: "NotifyCell"), Cell(reuseId: "NotifyCell") ]
    }
    
    override func render() {
        
    }
}

