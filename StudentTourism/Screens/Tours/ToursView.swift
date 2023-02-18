//
//  ToursView.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class ToursView: TableView {
    
    override func customizeUI() {
        cells = [Cell(reuseId: "SortCell"), Cell(reuseId: "FavCell"), Cell(reuseId: "FavCell"), Cell(reuseId: "FavCell"), Cell(reuseId: "FavCell") ]
    }
    
    override func render() {
        
    }
}

