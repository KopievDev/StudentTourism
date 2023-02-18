//
//  XibView.swift
//  Festa
//
//  Created by Ivan Kopiev on 15.10.2022.
//

import UIKit

class XibView: UIView {

    var contentView: UIView?
    @IBInspectable var nibName: String?
    @IBOutlet weak var xibDelegate: XibViewDelegate?
    var state: [String : Any?] = [:] {
        didSet { render() }
    }
    
    func xibSetup(){
        guard contentView == nil else { return }
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        setUp()
    }
    
    func setUp() {}
    func render() {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibName = String(describing: type(of: self))
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibName = String(describing: type(of: self))
        xibSetup()
    }
    
    
    private func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}

@objc protocol XibViewDelegate: AnyObject {
    
    func place(_ place: XibView, didClick sender:Any?)
    func place(_ place: XibView, didSelected index: Int)
    func place(_ place: XibView, shouldChange value: Any) -> Bool
    func place(_ place: XibView, shouldReturn textField: UITextField) -> Bool
    func place(_ place: XibView, didChange value: Any)
    func place(_ place: XibView, didEndEditing textField: UITextField)
    func place(_ place: XibView, shouldBeginEditing textField: UITextField) -> Bool
    func place(_ place: XibView, didTapLink link: String)
}

extension XibViewDelegate {
    
    func place(_ place: XibView, didClick sender:Any?) {}
    func place(_ place: XibView, didSelected index: Int) {}
    func place(_ place: XibView, shouldChange value: Any) -> Bool { return true }
    func place(_ place: XibView, shouldReturn textField: UITextField) -> Bool { return true }
    func place(_ place: XibView, didChange value: Any) {}
    func place(_ place: XibView, didEndEditing textField: UITextField) {}
    func place(_ place: XibView, shouldBeginEditing textField: UITextField) -> Bool { return true }
    func place(_ place: XibView, didTapLink link: String) {}
    
}
