//
//  BookVC.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class BookView: TableView {
    
    override func customizeUI() {
        cells = [Cell(reuseId: "BookCell"), Cell(reuseId: "BookCell"), Cell(reuseId: "BookCell"), Cell(reuseId: "BookCell"), Cell(reuseId: "BookCell") ]
    }
    
    override func render() {
        
    }
}

