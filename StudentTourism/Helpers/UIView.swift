//
//  UIView.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            if newValue > 0 {
                layer.masksToBounds = true
            }
        }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue / UIScreen.main.scale}
        get { return layer.borderWidth * UIScreen.main.scale }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor  }
        get { return (layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil) }
    }
    
}

extension UIButton {
    
    convenience init(text: String, deeplink: String?) {
        self.init(frame: .zero)
        setTitle(text, for: .normal)
        accessibilityLabel = deeplink
    }
    
    @objc public func animateIn(view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc public func animateOut(view viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseIn) {
            viewToAnimate.transform = .identity
        }
    }
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateIn(view:)), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateOut(view:)), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
}


extension UIView {
    
    var layoutConstraintTop: NSLayoutConstraint? {
        guard let superview = self.superview else { return nil }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == self, constraint.firstAttribute == .top {
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == self, constraint.secondAttribute == .top {
                return constraint
            }
        }
        return nil
    }

    var layoutConstraintLeft: NSLayoutConstraint? {
        guard let superview = self.superview else { return nil }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == self,
                (constraint.firstAttribute == .leading || constraint.firstAttribute == .left) {
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == self,
                (constraint.secondAttribute == .leading || constraint.secondAttribute == .left) {
                return constraint
            }
        }
        return nil
    }

    var layoutConstraintRight: NSLayoutConstraint? {
        guard let superview = self.superview else { return nil }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == self,
               (constraint.firstAttribute == .trailing || constraint.firstAttribute == .right){
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == self,
               (constraint.secondAttribute == .trailing || constraint.secondAttribute == .right){
                return constraint
            }
        }
        return nil
    }
    
    var layoutConstraintBottom: NSLayoutConstraint? {
        guard let superview = self.superview else { return nil }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == self, constraint.firstAttribute == .bottom {
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == self, constraint.secondAttribute == .bottom {
                return constraint
            }
        }
        return nil
    }
    
    var layoutConstraintHeight: NSLayoutConstraint? {
        for constraint in self.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == self, constraint.firstAttribute == .height, constraint.secondItem == nil {
                return constraint
            }
        }
        if let superview = self.superview {
            for constraint in superview.constraints {
                if let firstItem = constraint.firstItem as? UIView, firstItem == self, constraint.firstAttribute == .height, constraint.secondItem == nil {
                    return constraint
                }
            }
        }
        return nil
    }

    var layoutConstraintWidth: NSLayoutConstraint? {
        for constraint in self.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == self, constraint.firstAttribute == .width {
                return constraint
            }
        }
        if let superview = self.superview {
            for constraint in superview.constraints {
                if let firstItem = constraint.firstItem as? UIView, firstItem == self, constraint.firstAttribute == .width {
                    return constraint
                }
            }
        }
        return nil
    }

    func setConstraint(top : CGFloat) {
        layoutConstraintTop?.constant = top
    }
    
    func setConstraint(left : CGFloat) {
        layoutConstraintLeft?.constant = left
    }
    
    func setConstraint(right : CGFloat) {
        layoutConstraintRight?.constant = right
    }

    func setConstraint(bottom : CGFloat){
        layoutConstraintBottom?.constant = bottom
    }
    
    func setConstraint(width : CGFloat){
        if let layoutConstraintWidth = layoutConstraintWidth {
            layoutConstraintWidth.constant = width
        } else {
            addConstraint(width: width)
        }
    }

    func setConstraint(height : CGFloat){
        if let layoutConstraintHeight = layoutConstraintHeight {
            layoutConstraintHeight.constant = height
        } else {
            addConstraint(height: height)
        }
    }

    var constraintTop: CGFloat {
        return layoutConstraintTop?.constant ?? 0
    }

    var constraintLeft: CGFloat {
        return layoutConstraintLeft?.constant ?? 0
    }
    
    var constraintRight: CGFloat{
        return layoutConstraintRight?.constant ?? 0
    }
    
    var constraintBottom: CGFloat{
        return layoutConstraintBottom?.constant ?? 0
    }

    var constraintWidth: CGFloat{
        return layoutConstraintWidth?.constant ?? 0
    }
    
    var constraintHeight: CGFloat{
        return layoutConstraintHeight?.constant ?? 0
    }
    
    func setConstraint(left : CGFloat? = nil, top: CGFloat? = nil, right : CGFloat? = nil, bottom : CGFloat? = nil) {
        if let left = left { setConstraint(left: left) }
        if let top = top { setConstraint(top: top) }
        if let bottom = bottom { setConstraint(bottom: bottom) }
        if let right = right { setConstraint(right: right) }
    }
        
    func setConstraint(centerY : CGFloat){
        guard let superview = self.superview else { return }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == self, constraint.firstAttribute == .centerY {
                constraint.constant = centerY
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == self, constraint.secondAttribute == .centerY {
                constraint.constant = centerY
            }
        }
    }
        
    func constraint(_ attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint?{
        guard let superview = self.superview else { return nil }
        
        var check = attribute
        if check == .left { check = .leading }
        if check == .right { check = .trailing }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == self, constraint.firstAttribute == check {
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == self, constraint.secondAttribute == check {
                return constraint
            }
        }
        return nil
    }
        
    func constraintCenterY() -> CGFloat {
        guard let superview = self.superview else { return 0 }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == self, constraint.firstAttribute == .centerY {
                return constraint.constant
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == self, constraint.secondAttribute == .centerY {
                return constraint.constant
            }
        }
        return 0
    }
    
    func addConstraint(width: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func addConstraint(height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func addConstraint(view: UIView,
                       left: CGFloat? = nil, right: CGFloat? = nil,
                       top: CGFloat? = nil, bottom: CGFloat? = nil,
                       width: CGFloat? = nil, height: CGFloat? = nil,
                       centerX: CGFloat? = nil, centerY: CGFloat? = nil) {
        
        
        var constraints = [NSLayoutConstraint]()
        if let left = left { constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -left)) }
        if let right = right { constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: right)) }
        if let top = top { constraints.append(view.topAnchor.constraint(equalTo: self.topAnchor, constant: top)) }
        if let bottom = bottom { constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)) }
        if let width = width { constraints.append(view.widthAnchor.constraint(equalToConstant: width)) }
        if let height = height { constraints.append(view.heightAnchor.constraint(equalToConstant: height)) }
        if let centerX = centerX { constraints.append(centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerX)) }
        if let centerY = centerY { constraints.append(centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY)) }
        guard constraints.count > 0 else { return }
        self.addConstraints(constraints)
    }
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: convertFromCATransitionType(CATransitionType.fade))
    }
    
    func pushTransition(_ duration: CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
        return input.rawValue
    }

}

extension Date {
    
    func string(format: String = "dd.MM.yy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
	
	func subscriptionEndDateString(format: String = "dd.MM.yyyy") -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.string(from: self)
	}
}


extension UIView {
    enum Relation {
        case equal
        case lessOrEqual
        case greaterOrEqual
    }

    indirect enum Edge {
        case top(CGFloat)
        case left(CGFloat)
        case right(CGFloat)
        case bottom(CGFloat)
        case centerX(CGFloat)
        case centerY(CGFloat)
        case safeTop(CGFloat)
        case safeBottom(CGFloat)
        case spaceH(CGFloat)
        case spaceV(CGFloat)

        case multiplier(CGFloat, edge: Self)
        case relation(Relation, edge: Self)
        case priority(CGFloat, edge: Self)

        static let top = Self.top(0)
        static var left = Self.left(0)
        static var right = Self.right(0)
        static var bottom  = Self.bottom(0)
        static var centerX  = Self.centerX(0)
        static var centerY  = Self.centerY(0)
        static var safeTop = Self.safeTop(0)
        static var safeBottom = Self.safeBottom(0)
    }
    
    @discardableResult
    func pinTo(_ view: UIView, edges: Edge...) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        edges.forEach { edge in
            pinTo(view, edge: edge)
        }
        return self
    }

    @discardableResult
    func pinTo(_ view: UIView, edges: [Edge]) -> Self {
        edges.forEach { edge in
            pinTo(view, edge: edge)
        }
        return self
    }
    
    func padding(edges: Edge...) -> UIView {
        let view = UIView().backgroundColor(.clear)
        var edges = edges
        if !(edges.contains{
            if case .left = $0 { return true }
            else { return false }
        }) {
            edges.append(.left)
        }
        if !(edges.contains{
            if case .right = $0 { return true }
            else { return false }
        }) {
            edges.append(.right)
        }
        if !(edges.contains{
            if case .top = $0  { return true }
            else if case .bottom = $0 { return true }
            else if case .centerY = $0 { return true }
            else { return false }
        }) {
            edges.append(.top)
            edges.append(.bottom)
        }
        
        if self.superview != view {
            view.addSubview(self)
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.pinTo(view, edges: edges)
        return view
    }

    private func pinTo(_ view: UIView, edge: Edge) {
        switch edge {
        case .top(let constant):
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        case .left(let constant):
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
        case .right(let constant):
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant).isActive = true
        case .bottom(let constant):
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
        case .centerX(let constant):
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        case .centerY(let constant):
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        case .spaceH(let constant):
            rightAnchor.constraint(equalTo: view.leftAnchor, constant: -constant).isActive = true
        case .spaceV(let constant):
            bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant).isActive = true
        case .multiplier(let multiplier, edge: let edge):
            pinTo(view, edge: edge, multiplier: multiplier)
        case .relation(let relation, edge: let edge):
            pinTo(view, edge: edge, relation: relation)
        case .priority(let priority, edge: let edge):
            pinTo(view, edge: edge, priority: priority)
        case .safeBottom(let constant):
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant).isActive = true
        case .safeTop(let constant):
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
        }
    }

    private func pinTo(_ view: UIView, edge: Edge, multiplier: CGFloat) {
        switch edge {
        case .top:
            topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor,
                                 multiplier: multiplier).isActive = true
        case .left:
            leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor,
                                  multiplier: multiplier).isActive = true
        case .right:
            rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor,
                                   multiplier: multiplier).isActive = true
        case .bottom:
            bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor,
                                    multiplier: multiplier).isActive = true
        case .centerX:
            centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor,
                                     multiplier: multiplier).isActive = true
        case .centerY:
            centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor,
                                     multiplier: multiplier).isActive = true
        case .spaceH:
            rightAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor,
                                   multiplier: multiplier).isActive = true
        case .spaceV:
            bottomAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor,
                                    multiplier: multiplier).isActive = true
        case .multiplier(_, edge: _):
            fatalError("Can't be multiplier with multiplier")
        case .relation(_, edge: _):
            fatalError("Can't be relation with relation")
        case .priority(_, edge: _):
            fatalError("Didn't implemented priority attribute")
        case .safeTop:
            topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
                                 multiplier: multiplier).isActive = true
        case .safeBottom:
            bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor,
                                 multiplier: multiplier).isActive = true
        }
    }

    private func pinTo(_ view: UIView, edge: Edge, priority: CGFloat) {
        switch edge {
        case .top(let constant):
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant).priority(priority).isActive = true
        case .left(let constant):
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).priority(priority).isActive = true
        case .right(let constant):
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant).priority(priority).isActive = true
        case .bottom(let constant):
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).priority(priority).isActive = true
        case .centerX(let constant):
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).priority(priority).isActive = true
        case .centerY(let constant):
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).priority(priority).isActive = true
        case .spaceH(let constant):
            rightAnchor.constraint(equalTo: view.leftAnchor, constant: -constant)
                .priority(priority).isActive = true
        case .spaceV(let constant):
            bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant)
                .priority(priority).isActive = true
        case .multiplier(_, edge: _):
            fatalError("Didn't implemented multipier attribute")
        case .relation(_, edge: _):
            fatalError("Didn't implemented relation attribute")
        case .priority(_, edge: _):
            fatalError("Didn't implemented priority attribute")
        case .safeBottom(let constant):
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant).priority(priority).isActive = true
        case .safeTop(let constant):
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant).priority(priority).isActive = true
        }
    }
        
    private func pinTo(_ view: UIView, edge: Edge, relation: Relation) {
        switch relation {
        case .equal:
            fatalError("Use without relation")
        case .lessOrEqual:
            switch edge {
            case .top(let constant):
                topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: constant).isActive = true
            case .left(let constant):
                leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: constant).isActive = true
            case .right(let constant):
                rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -constant).isActive = true
            case .bottom(let constant):
                bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -constant).isActive = true
            case .centerX(let constant):
                centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: constant).isActive = true
            case .centerY(let constant):
                centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: constant).isActive = true
            case .spaceH(let constant):
                rightAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: -constant).isActive = true
            case .spaceV(let constant):
                bottomAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: -constant).isActive = true
            case .multiplier(_, edge: _):
                fatalError("Can't be multiplier with relation")
            case .relation(_, edge: _):
                fatalError("Can't be relation with relation")
            case .priority(_, edge: _):
                fatalError("Didn't implemented priority attribute")
            case .safeTop(let constant):
                topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
                                     constant: constant).isActive = true
            case .safeBottom(let constant):
                bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                        constant: constant).isActive = true
            }
        case .greaterOrEqual:
            switch edge {
            case .top(let constant):
                topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: constant).isActive = true
            case .left(let constant):
                leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: constant).isActive = true
            case .right(let constant):
                rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -constant).isActive = true
            case .bottom(let constant):
                bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -constant).isActive = true
            case .centerX(let constant):
                centerXAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: constant).isActive = true
            case .centerY(let constant):
                centerYAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: constant).isActive = true
            case .spaceH(let constant):
                rightAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: -constant)
                    .isActive = true
            case .spaceV(let constant):
                bottomAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: -constant)
                    .isActive = true
            case .multiplier(_, edge: _):
                fatalError("Can't be multiplier with relation")
            case .relation(_, edge: _):
                fatalError("Can't be relation with relation")
            case .priority(_, edge: _):
                fatalError("Didn't implemented priority attribute")
            case .safeTop(let constant):
                topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
                                     constant: constant).isActive = true
            case .safeBottom(let constant):
                bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                        constant: constant).isActive = true
            }
        }
    }
    
    enum LayoutDimension { case width, height }
    
    @discardableResult
    func width(_ view: UIView, equalTo size: LayoutDimension, multiplier: CGFloat = 1) -> Self  {
        switch size {
        case .width:
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
        case .height:
            widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
        }
        return self
    }
    
    @discardableResult
    func height(_ view: UIView, equalTo size: LayoutDimension, multiplier: CGFloat = 1) -> Self  {
        switch size {
        case .width:
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
        case .height:
            widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
        }
        return self
    }
    
    
}


extension UIView {
    
    func addToSuper(view: UIView){
        if superview != view{
            view.addSubview(self)
        }
        
        translatesAutoresizingMaskIntoConstraints = false;
        pinTo(view, edges: .left, .top, .right, .bottom)

    }
    
    func addToCenter(view: UIView){
        if superview != view{
            view.addSubview(self)
        }
        
        translatesAutoresizingMaskIntoConstraints = false;
        pinTo(view, edges: .centerX, .centerY)
    }

    func addSubview(_ view: UIView, edges: Edge...) {
        if view.superview != self {
            addSubview(view)
        }

        view.translatesAutoresizingMaskIntoConstraints = false
        view.pinTo(self, edges: edges)
    }
    
}

extension UIView {
    
    @discardableResult
    func size(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        addConstraint(width: width, height: height)
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        cornerRadius = radius
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    func isHidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }
    
    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult
    func addShadow() -> Self {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2
        return self
    }

}

extension UIView {
    
    //MARK: - Constraints
    struct OrientationType: OptionSet {
        let rawValue: Int
        
        static let fill             = OrientationType(rawValue: 1 << 0)
        static let vertical         = OrientationType(rawValue: 1 << 1)
        static let horizontal       = OrientationType(rawValue: 1 << 2)
        static let verticalFill:    OrientationType = [.fill, .vertical]
        static let horizontalFill:  OrientationType = [.fill, .horizontal]
    }
    
    func addDownToSuper(view: UIView){
        if self.superview != view{
            view.addSubview(self)
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(h)-[view(h)]|", options: [], metrics: ["h" : view.frame.height], views: ["view" : self]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view" : self]))
    }
    
    func addVertical(views: [UIView], fill: Bool = false){
        add(views: views, orientation: fill ? .verticalFill : .vertical)
    }
    
    
    func addHorizontal(views: [UIView], fill: Bool = false){
        add(views: views, orientation: fill ? .horizontalFill : .horizontal)
    }
    
    func add(views: [UIView], orientation: OrientationType){
        var ms = String()
        var mdi = [String : UIView]()
        ms.append( orientation.contains(.vertical) ? "V:|" : "H:|")
        for (idx, view) in views.enumerated() {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            let s = "view\(idx)"
            let v = (orientation.contains(.vertical)) ? "\(view.frame.width)" : "\(view.frame.height)"
            let f = (orientation.contains(.vertical)) ? "H:|[\(s)(\(v))]|" : "V:|[\(s)(\(v))]|"
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: f, options: [], metrics: nil, views: [s : view]))
            if (orientation.contains(OrientationType.fill)){
                ms.append("[\(s)(\(idx==0 ? ">=40" : "==view0"))]")
            }else{
                ms.append("[\(s)(\( orientation.contains(.vertical) ? view.frame.size.height : view.frame.size.width))]")
            }
            mdi[s] = view
        }
        ms.append("|")
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: ms, options: [], metrics: nil, views: mdi))
        
    }
    
    func insert(views: [UIView], after view: UIView){
        var constraint: NSLayoutConstraint? = nil
        var bottomView: UIView? = nil;
        for con in constraints{
            if let firstItem = con.firstItem as? UIView, firstItem == view && con.firstAttribute == NSLayoutConstraint.Attribute.bottom, let secondItem = con.secondItem as? UIView {
                bottomView = secondItem
                constraint = con
            }
            if let secondItem = con.secondItem as? UIView, secondItem == view && con.secondAttribute == NSLayoutConstraint.Attribute.bottom, let firstItem = con.firstItem as? UIView {
                bottomView = firstItem
                constraint = con
            }
            
        }
        
        if bottomView == self {
            bottomView = nil
        }
        
        var mdi = ["topView": view]
        if let _ = bottomView {
            mdi["bottomView"] = bottomView
        }
        var ms: String = "V:[topView]"
        
        for (index, v) in views.enumerated() {
            self.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view" : v]))
            ms.append("[view\(index)(\(v.frame.size.height))]")
            mdi["view\(index)"] = v
        }
        if let con = constraint {
            self.removeConstraint(con)
        }
        
        if let _ = bottomView {
            ms.append("[bottomView]")
        } else {
            ms.append("|")
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: ms, options: [], metrics: nil, views: mdi))
    }
    
    func insert(views: [UIView], from start: UIView, to end: UIView){
        var mdi = ["topView" : start, "bottomView" : end]
        var ms = "V:[topView]-"
        
        for (index, v) in views.enumerated() {
            self.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view" : v]))
            ms.append("[view\(index)]-")
            mdi["view\(index)"] = v
        }
        ms.append("[bottomView]")
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: ms, options: [], metrics: nil, views: mdi))
    }
    
    func setConstraint(frame: CGRect){
        setConstraint(left: frame.origin.x)
        setConstraint(top: frame.origin.y)
        setConstraint(width: frame.width)
        setConstraint(height: frame.height)
    }

    func addConstraint(width: CGFloat? = nil, height: CGFloat? = nil) {
        
        if let width = width {
            let constraint = self.widthAnchor.constraint(equalToConstant: width)
            constraint.priority = UILayoutPriority(999)
            constraint.isActive = true
        }
        if let height = height {
            let constraint = self.heightAnchor.constraint(equalToConstant: height)
            constraint.priority = UILayoutPriority(999)
            constraint.isActive = true

        }
        guard constraints.count > 0 else { return }
        self.addConstraints(constraints)
    }
	
	func anchor(left: NSLayoutXAxisAnchor? = nil,
				right: NSLayoutXAxisAnchor? = nil,
				top: NSLayoutYAxisAnchor? = nil,
				bottom: NSLayoutYAxisAnchor? = nil,
				leftConstant: CGFloat = 0,
				rightConstant: CGFloat = 0,
				topConstant: CGFloat = 0,
				bottomConstant: CGFloat = 0,
				height: CGFloat = 0,
				width: CGFloat = 0) {
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if let left = left {
			leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
		}
		
		if let right = right {
			rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
		}
		
		if let top = top {
			topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
		}
		
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
		}
		
		if width > 0 {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
		
		if height > 0 {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}
    
}

extension NSLayoutConstraint {
    @discardableResult
    func priority(_ priority: CGFloat) -> Self {
        self.priority = UILayoutPriority(Float(priority))
        return self
    }
    
    func set(constant: CGFloat) {
        isActive = false
        self.constant = constant
        isActive = true
    }
}


extension UILabel {
    
    convenience init(title: String? = nil, font: UIFont? = .systemFont(ofSize: 12), color: UIColor = Asset.Colors.sBlack.color,
                     alignment: NSTextAlignment = .left, lines: Int = 1, withConstraints: Bool = false) {
        self.init(frame: CGRect.zero)
        self.font = font
        text = title
        textColor = color
		lineBreakMode = .byWordWrapping
        numberOfLines = lines
        textAlignment = alignment
        translatesAutoresizingMaskIntoConstraints = !withConstraints
    }
    
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
}

extension UIView {
    
    convenience init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addConstraint(width: width, height: height)
    }
    
    convenience init(cornerRadius: CGFloat = 8 , color: UIColor, gesture: UIGestureRecognizer? = nil) {
        self.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.cornerRadius = cornerRadius
        self.backgroundColor = color
        if let gesture = gesture {
            addGestureRecognizer(gesture)
            isUserInteractionEnabled = true
        }
    }
}

extension UIAlertController {
    
    class func sheet(message: String?, buttons: [String], cancel: String?, block: ((Int) -> ())? = nil ){
        sheet(title: nil, message: message, buttons: buttons, cancel: cancel, block: block)
    }
    
    class func sheet(title: String?, message: String?, buttons: [String], cancel: String?, block: ((Int) -> ())? = nil ){
        let alert =  UIAlertController.init(title: title, message: message, preferredStyle:UIAlertController.Style.actionSheet)
        
        for (index, value) in buttons.enumerated() {
            
            let defaultAction = UIAlertAction.init(title: value, style: UIAlertAction.Style.default) { (UIAlertAction) in
                if block != nil {
                    block!(index)
                }
            }.with(textColor: .darkText)
            alert.addAction(defaultAction)
            
        }
        
        if (cancel != nil) {
            let defaultAction = UIAlertAction.init(title: cancel, style: UIAlertAction.Style.cancel) { (UIAlertAction) in
                if block != nil {
                    block!(-1)
                }
            }
            alert.addAction(defaultAction)
        }
        
        if let popoverController = alert.popoverPresentationController, let top = UIApplication.topViewController()?.view {
            popoverController.sourceView = top
            popoverController.permittedArrowDirections = []
            popoverController.sourceRect = CGRect(x: top.bounds.midX, y: top.bounds.maxY, width: 0, height: 0)
        }
        
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}

extension UIAlertAction {
    
    var titleTextColor: UIColor? {
        get { return self.value(forKey: "titleTextColor") as? UIColor }
        set { self.setValue(newValue, forKey: "titleTextColor") }
    }
    
    func with(textColor: UIColor) -> UIAlertAction {
        titleTextColor = textColor
        return self
    }
}

@IBDesignable
class Button: UIButton {
    @IBInspectable
    var withAnimate: Bool = false {
        didSet { withAnimate ? startAnimatingPressActions():() }
    }
}

extension UIStackView {
    
    func addArrangedSubview(views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
    
    func removeArrangedAllSubview() {
        let views = self.arrangedSubviews
        views.forEach {
            self.removeArrangedSubview( $0)
            $0.removeFromSuperview()
        }
    }
    
    func removeAll() {
        while let view = arrangedSubviews.first {
            removeArrangedSubview(view)
        }
        while let view = subviews.first {
            view.removeFromSuperview()
        }
    }
    
    func remove(at index: Int) {
        guard arrangedSubviews.count > index else { return }
        let view = arrangedSubviews[index]
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    convenience init(axis: NSLayoutConstraint.Axis,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill,
                     spacing: CGFloat = 0,
                     arrangedSubviews: [UIView]? = nil) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        if let arrangedSubviews = arrangedSubviews {
            self.addArrangedSubview(views: arrangedSubviews)
        }
    }
    
    
}

extension UIButton {
    
    @discardableResult
    func withAnimate(_ animate: Bool = true) -> Self {
        animate ? startAnimatingPressActions():()
        return self
    }
    
    convenience init(text: String, tag: Int) {
        self.init(frame: .zero)
        setTitle(text, for: .normal)
        self.tag = tag
    }
}

extension UIView {
    func asImage() -> UIImage {
        UIGraphicsImageRenderer(bounds: bounds).image { layer.render(in: $0.cgContext) }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
