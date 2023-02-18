//
//  UITableViewCell.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

protocol IdentifiableCell {
    static var reuseId: String { get }
}

extension IdentifiableCell {
    static var reuseId: String { "\(self)" }
}

extension UITableViewCell: IdentifiableCell {}
extension UICollectionViewCell: IdentifiableCell {}

class ReusableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func render(_ cell: Cell) { }
    func setUp() {}
    func render(data: [String:Any?]) {}

}
