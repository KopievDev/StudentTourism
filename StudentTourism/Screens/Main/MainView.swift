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
    @IBOutlet var hotelsCollection: CityCollection!
    @IBOutlet var promotionCollection: PromotionCollection!
    @IBOutlet var popularCollection: PopularCollection!


    
    override func customizeUI() {
        bannerCollection.items = [Item(reuseId: "BannerCell"),Item(reuseId: "BannerCell"),Item(reuseId: "BannerCell"),Item(reuseId: "BannerCell") ]
        cityCollection.items = [Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell") ]
        hotelsCollection.items = [Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"), Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell") ]
        promotionCollection.items = [Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"), Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell") ]
        popularCollection.items = [Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"), Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell"),Item(reuseId: "CityCell") ]


    }
    
    override func render() {
        
    }
}


class BannerCollection: CollectionView {
    @IBOutlet var pageControl: UIPageControl!
    
    override func setUp() {
        CellSize(widthScale: 0.9, aspectRatio: 0.6, insetX: 16).forCollectionView(collectionView, lineSpacing: 16, scrollDirection: .horizontal, withDecelerateFast: true)
        pageControl.numberOfPages = items.count
    }
    
    override func render(data: Items) {
        super.render(data: data)
        pageControl.numberOfPages = items.count
        
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        super.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        let offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        pageControl.currentPage = Int( roundedIndex)
    }
    
}

class CityCollection: CollectionView {

   override func setUp() {
       CellSize(widthScale: 0.38, aspectRatio: 1.6, insetX: 16).forCollectionView(collectionView, lineSpacing: 16, scrollDirection: .horizontal, withDecelerateFast: true)
    }

}

class PromotionCollection: CollectionView {

   override func setUp() {
       CellSize(widthScale: 0.38, aspectRatio: 1.3, insetX: 16).forCollectionView(collectionView, lineSpacing: 16, scrollDirection: .horizontal, withDecelerateFast: true)
    }

}

class PopularCollection: CollectionView {

   override func setUp() {
       CellSize(widthScale: 0.62, aspectRatio: 0.78, insetX: 16).forCollectionView(collectionView, lineSpacing: 16, scrollDirection: .horizontal, withDecelerateFast: true)
    }

}

