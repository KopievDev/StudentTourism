//
//  TourViewView.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class TourViewView: BaseView {
    
    @IBOutlet var roomCollection: RoomCollection!

    
    override func customizeUI() {
        roomCollection.items = [Item(reuseId: "BannerCell"),Item(reuseId: "BannerCell"),Item(reuseId: "BannerCell"),Item(reuseId: "BannerCell") ]
    
    }
}

class RoomCollection: CollectionView {
    @IBOutlet var pageControl: UIPageControl!
    
    override func setUp() {
        CellSize(widthScale: 0.9, aspectRatio: 1.17, insetX: 16).forCollectionView(collectionView, lineSpacing: 16, scrollDirection: .horizontal, withDecelerateFast: true)
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
