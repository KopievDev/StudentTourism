//
//  FavView.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class FavView: TableView {
    
    override func customizeUI() {
        cells = [Cell(reuseId: "FavCell"), Cell(reuseId: "FavCell"), Cell(reuseId: "FavCell"), Cell(reuseId: "FavCell"), Cell(reuseId: "FavCell") ]
    }
    
    override func render() {
        
    }
}

