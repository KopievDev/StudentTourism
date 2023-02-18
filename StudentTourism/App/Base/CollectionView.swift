//
//  CollectionView.swift
//  Festa
//
//  Created by Ivan Kopiev on 15.10.2022.
//

import UIKit

typealias Items = [Item]
struct Item {
    var reuseId: String
    var data: [String:Any?] = [:]
}

class CollectionView: UIView {
    @IBOutlet var collectionView: UICollectionView!
    var items: Items = [] {
        didSet { collectionView.reloadData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        setUp()
    }
    
    func setUp() {
		CellSize(widthScale: 0.2, aspectRatio: 1, insetX: 16).forCollectionView(collectionView, lineSpacing: nil, scrollDirection: nil)
    }
    
    func render(data: Items) {
        items = data
    }
    
}


struct CellSize {
    let widthScale: CGFloat
    let aspectRatio: CGFloat
    let screenSize = UIScreen.main.bounds.size
    var cellWeight: CGFloat { floor(screenSize.width * widthScale) }
    var cellHeight: CGFloat { floor(cellWeight * aspectRatio) }
//    var insetX: CGFloat { (screenSize.width - cellWeight) / 2.0 } // 1 element
    var insetX: CGFloat

    
    func forCollectionView(_ collectionView: UICollectionView?, lineSpacing: CGFloat?, scrollDirection: UICollectionView.ScrollDirection?, withDecelerateFast: Bool = false) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        flowLayout.scrollDirection = scrollDirection ?? .horizontal
        flowLayout.minimumLineSpacing = lineSpacing ?? 16
        flowLayout.itemSize = CGSize(width: cellWeight, height: cellHeight)
        collectionView?.collectionViewLayout = flowLayout
        collectionView?.isPagingEnabled = false
        collectionView?.showsHorizontalScrollIndicator = (scrollDirection ?? .horizontal) == .vertical ? true : false
        if (scrollDirection ?? .horizontal) != .vertical {
            collectionView?.setConstraint(height: cellHeight)
        }
        if withDecelerateFast {
            collectionView?.decelerationRate = .fast
        }
        collectionView?.reloadData()
    }
}

extension CollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { items.count }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = items[indexPath.row].reuseId
        let data = items[indexPath.row].data
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath)
        (cell as? CollectionCell)?.render(data:data)
        return cell
    }
}

extension CollectionView: UIScrollViewDelegate, UICollectionViewDelegate {
  
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}


class CollectionCell: UICollectionViewCell {
    
    func setUp() {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func render(data: [String:Any?]) {}
}
