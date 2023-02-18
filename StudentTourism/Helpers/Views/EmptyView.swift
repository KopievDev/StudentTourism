//
//  EmptyView.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

@IBDesignable
class EmptyView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var heightCnst: NSLayoutConstraint!
    @IBInspectable var defaultHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [self] in
            let diff = scrollView.frame.height - scrollView.contentSize.height - 20
            heightCnst.constant = max(defaultHeight, diff)
            scrollView.layoutIfNeeded()
        }
    }
}
