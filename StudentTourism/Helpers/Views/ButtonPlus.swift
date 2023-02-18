//
//  ButtonPlus.swift
//  Festa
//
//  Created by Ivan Kopiev on 18.10.2022.
//

import UIKit

@IBDesignable
class ButtonPlus: UIButton {
    @IBInspectable var text: String = "" {
        didSet { textLabel.text = text }
    }
    
    @IBInspectable var image: UIImage? = UIImage(named: "ic_bubble") {
        didSet { imgView.image = image }
    }
    let imgView: UIImageView = UIImageView(image: UIImage(named: "ic_bubble"))
    let textLabel: UILabel = UILabel(font: .boldSystemFont(ofSize: 16), color: .fDarkGray, alignment: .left, lines: 0, withConstraints: true)
    let plusImg: UIImageView = UIImageView(image: UIImage(named: "ic_plus"))
    let plusView: UIView = UIView(width: 46, height: 46).backgroundColor(.white)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp() {
        startAnimatingPressActions()
        addSubview(imgView, edges: .left(11), .top(30))
        imgView.size(width: 32, height: 32)
        addSubview(textLabel, edges: .right(11))
        textLabel.pinTo(imgView, edges: .centerY)
        textLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 4).isActive = true
        addSubview(plusView, edges: .right(11), .bottom(19))
        plusView.addSubview(plusImg, edges: .top, .left, .bottom, .right)
        plusView.cornerRadius = 23
        plusImg.contentMode = .center
        textLabel.text = text
        imgView.image = image
    }
}

@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

	var colors: [CGColor?] = [] { didSet { updateColors()} }
    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
		if colors.isEmpty {
			gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
		} else {
			guard let providedColors = colors as? [CGColor] else {
				gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
				return
			}
			gradientLayer.colors = providedColors
		}
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }

}
@IBDesignable
class CornersView: View {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCorners(cornerRadius: 16)
    }
    
}

@IBDesignable class View: UIView {
    
    @IBInspectable var shadowColor: UIColor? { didSet { updateShadow() }}
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 1, height: 1) { didSet { updateShadow() }}
    @IBInspectable var shadowOpacity: CGFloat = 0.5 { didSet { updateShadow() }}
    @IBInspectable var shadowRadius: CGFloat = 1 { didSet { updateShadow() }}
    
    override func prepareForInterfaceBuilder(){
        initialization()
        super.prepareForInterfaceBuilder()
    }
    
    func initialization(){
    }
    
    #if !TARGET_INTERFACE_BUILDER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    #endif
    
    func updateShadow(){
        if let shadowColor = shadowColor {
            
            layer.masksToBounds = false
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = Float(shadowOpacity)
            layer.shadowRadius = shadowRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
    }
}

extension UIView {
    func roundCorners(cornerRadius: Double, masks: CACornerMask = .bottom) {
        mask = nil
        layer.cornerRadius = CGFloat(cornerRadius)
        clipsToBounds = true
        layer.maskedCorners = masks
    }
}

extension CACornerMask {
    static var bottom: CACornerMask { [.layerMinXMinYCorner, .layerMaxXMinYCorner] }
}
