//
//  Alert.swift
//  Festa
//
//  Created by Ivan Kopiev on 16.11.2022.
//

import UIKit

struct Alert {
    enum HapticStyle { case error, success, warning, none }
    
    static func show(title: String? = nil, message: String? = nil, buttons: [String], haptic: HapticStyle = .none, completion: IndexBlock? = nil) {
        let alert = AlertView(title: title, message:message, buttons:buttons, completion: completion)
        alert.show()
        switch haptic {
        case .error: Haptic.notification(.error)
        case .success: Haptic.notification(.success)
        case .warning: Haptic.notification(.warning)
        case .none: break
        }
    }
    
    static func showWIthTextfiled(title: String? = nil, message: String? = nil, button: String = "OK", completion: StringBlock? = nil) {
        let alert = AlertView(title: title, message: message, buttons:[button], withTextfield: true)
        alert.textCompletion = completion
        alert.show()
    }
}

class AlertView: BlurView {
    private let formView = UIView(cornerRadius: 16, color: .white)
    private let titleLabel = UILabel(font: .boldSystemFont(ofSize: 16), color: UIColor.fDarkGray, alignment: .center, lines: 0)
    private let messageLabel = UILabel(font: .systemFont(ofSize: 15), color: UIColor.fDarkGray, alignment: .center, lines: 0)
    private lazy var textfield = UITextField(cornerRadius: 10, color: .white).size(height: 45)
    private var completion: IndexBlock? = nil
    var textCompletion: StringBlock? = nil
    
    init(title: String?, message: String?, buttons: [String], withTextfield: Bool = false, completion: IndexBlock? = nil) {
        super.init(radius: 5, color: .fDarkGray, colorAlpha: 0.4)
        setUp(title: title, message: message, buttons: buttons, withTextfield: withTextfield)
        self.completion = completion
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUp(title: String?, message: String?, buttons:[String] = [], withTextfield: Bool = false) {
        addSubview(formView, edges: .centerX, .centerY(-50))
        formView.width(self, equalTo: .width, multiplier: 0.8)
        let buts = buttons.enumerated().map {
            UIButton(text: $0.element, tag: $0.offset).size(height: 45).backgroundColor(.fDarkGray).tintColor(.white).cornerRadius(10).withAnimate()
        }
        buts.forEach { $0.addTarget(self, action: #selector(didTap(button:)), for: .touchUpInside) }
        let arrangedSubviews = withTextfield ?
        [titleLabel, messageLabel, UIView(height: 10), textfield, UIView(height: 10)] + buts : [titleLabel, messageLabel, UIView(height: 10) ] + buts
        let stack = UIStackView(axis: .vertical, spacing: 4, arrangedSubviews: arrangedSubviews)
        formView.addSubview(stack, edges: .top(16), .left(16), .right(16), .bottom(16))
        titleLabel.text = title
        messageLabel.text = message
        textfield.borderWidth = 1
        textfield.borderColor = .fDarkGray
        textfield.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        formView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTap(form:))))
        addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hide)))
    }
    
    @objc func didTap(button: UIButton) {
        Haptic.selection()
        completion?(button.tag)
        textCompletion?(textfield.text ?? "")
        hide()
    }
    
    @objc func didTap(form: UIView) {
        endEditing(true)
    }
    
    @objc func hide() {
        if superview != nil {
            UIView.animate(withDuration: 0.3) {
                self.alpha = 0
            } completion: { _ in
                self.removeFromSuperview()
            }
        }
    }
    
    func show() {
        guard let window = UIApplication.shared.windows.first else {return}
        window.addSubview(self)
        window.bringSubviewToFront(self)
        frame = window.frame
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        alpha = 0
        UIView.animate(withDuration: 0.3) { self.alpha = 1}
    }
    
}

@IBDesignable
class BlurView: UIView {
    
    private enum Constants {
        static let blurRadiusKey = "blurRadius"
        static let colorTintKey = "colorTint"
        static let colorTintAlphaKey = "colorTintAlpha"
    }
    
    // MARK: - Public
    
    /// Blur radius. Defaults to `10`
    @IBInspectable var blurRadius: CGFloat = 10.0 {
        didSet { _setValue(blurRadius, forKey: Constants.blurRadiusKey) }
    }
    
    /// Tint color. Defaults to `nil`
    @IBInspectable var colorTint: UIColor? {
        didSet { _setValue(colorTint, forKey: Constants.colorTintKey) }
    }
    
    /// Tint color alpha. Defaults to `0.2`
    @IBInspectable var colorTintAlpha: CGFloat = 0.2 {
        didSet { _setValue(colorTintAlpha, forKey: Constants.colorTintAlphaKey) }
    }
    
    /// Visual effect view layer.
    public var blurLayer: CALayer { visualEffectView.layer }
    
    // MARK: - Initialization
    
    public init(radius: CGFloat = 10.0, color: UIColor? = nil, colorAlpha: CGFloat = 0.2) {
        blurRadius = radius
        super.init(frame: .zero)
        backgroundColor = .clear
        setupViews()
        defer {
            blurRadius = radius
            colorTint = color
            colorTintAlpha = colorAlpha
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupViews()
        defer {
            blurRadius = 10.0
            colorTint = nil
            colorTintAlpha = 0.2
        }
    }
    
    
    // MARK: - Private
    
    /// Visual effect view.
    private lazy var visualEffectView: UIVisualEffectView = {
        if #available(iOS 14.0, *) {
            return UIVisualEffectView(effect: customBlurEffect_ios14)
        } else {
            return UIVisualEffectView(effect: customBlurEffect)
        }
    }()
    
    /// Blur effect for IOS >= 14
    private lazy var customBlurEffect_ios14: CustomBlurEffect = {
        let effect = CustomBlurEffect.effect(with: .extraLight)
        effect.blurRadius = blurRadius
        return effect
    }()
    
    /// Blur effect for IOS < 14
    private lazy var customBlurEffect: UIBlurEffect = {
        return (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
    }()
    
    /// Sets the value for the key on the blurEffect.
    private func _setValue(_ value: Any?, forKey key: String) {
        if #available(iOS 14.0, *) {
            if key == Constants.blurRadiusKey {
                updateViews()
            }
            let subviewClass = NSClassFromString("_UIVisualEffectSubview") as? UIView.Type
            let visualEffectSubview: UIView? = visualEffectView.subviews.filter({ type(of: $0) == subviewClass }).first
            visualEffectSubview?.backgroundColor = colorTint
            visualEffectSubview?.alpha = colorTintAlpha
        } else {
            customBlurEffect.setValue(value, forKeyPath: key)
            visualEffectView.effect = customBlurEffect
        }
    }
    
    private func setupViews() {
        addSubview(visualEffectView, edges: .top, .left, .right, .bottom)
        clipsToBounds = true
    }
    
    /// Update visualEffectView for ios14+, if we need to change blurRadius
    private func updateViews() {
        if #available(iOS 14.0, *) {
            visualEffectView.removeFromSuperview()
            let newEffect = CustomBlurEffect.effect(with: .extraLight)
            newEffect.blurRadius = blurRadius
            customBlurEffect_ios14 = newEffect
            visualEffectView = UIVisualEffectView(effect: customBlurEffect_ios14)
            setupViews()
        }
    }
}

class CustomBlurEffect: UIBlurEffect {
    
    public var blurRadius: CGFloat = 10.0
    
    private enum Constants {
        static let blurRadiusSettingKey = "blurRadius"
    }
    
    class func effect(with style: UIBlurEffect.Style) -> CustomBlurEffect {
        let result = super.init(style: style)
        object_setClass(result, self)
        return result as! CustomBlurEffect
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let result = super.copy(with: zone)
        object_setClass(result, Self.self)
        return result
    }
    
    override var effectSettings: AnyObject {
        get {
            let settings = super.effectSettings
            settings.setValue(blurRadius, forKey: Constants.blurRadiusSettingKey)
            return settings
        }
        set {
            super.effectSettings = newValue
        }
    }
    
}

private var AssociatedObjectHandle: UInt8 = 0

extension UIVisualEffect {
    @objc var effectSettings: AnyObject {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as AnyObject
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
