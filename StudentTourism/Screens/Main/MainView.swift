//
//  MainView.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class MainView: BaseView {
    @IBOutlet var bannerCollection: BannerCollection!
    @IBOutlet var cityCollection: CityCollection!

    
    override func customizeUI() {
        bannerCollection.items = [Item(reuseId: "BannerCell"),Item(reuseId: "BannerCell"),Item(reuseId: "BannerCell"),Item(reuseId: "BannerCell") ]
        cityCollection.items = [Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell") ]

    }
    
    override func render() {
        
    }
}


class BannerCollection: CollectionView {

   override func setUp() {
       CellSize(widthScale: 0.9, aspectRatio: 0.6, insetX: 16).forCollectionView(collectionView, lineSpacing: 16, scrollDirection: .horizontal, withDecelerateFast: true)
    }

}


class CityCollection: CollectionView {

   override func setUp() {
       CellSize(widthScale: 0.38, aspectRatio: 1.6, insetX: 16).forCollectionView(collectionView, lineSpacing: 16, scrollDirection: .horizontal, withDecelerateFast: true)
    }

}
