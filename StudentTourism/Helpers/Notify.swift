//
//  Notify.swift
//  Festa
//
//  Created by Ivan Kopiev on 10.10.2022.
//

import UIKit

/// Вызов уведомления
enum Notify {
    
    /// Выводит уведомление  (NotificationView)
    /// - Parameters:
    ///   - title: Уведомление
    ///   - duration: Время показа в секундах (по умолчанию 4 сек)
    ///   - haptic: Тактильный отклик (Haptic Engine) (по умолчанию success)
    ///   - completion: Блок завершения  (по умолчанию nil)
    static func with(title: String, duration: TimeInterval = 4, haptic: UINotificationFeedbackGenerator.FeedbackType = .success, _ completion: VoidBlock? = nil) {
        let alert = NotificationViewAlert(title: title, delay: duration, haptic: haptic, completion: completion)
        alert.present()
    }
    
    static func with(title: String, message: String,
                     type: NotifyType = .info,
                     duration: TimeInterval = 4,
                     haptic: UINotificationFeedbackGenerator.FeedbackType = .success,
                     _ completion: VoidBlock? = nil) {
        let alert = NotificationViewAlert(title: title, message: message, type: type, delay: duration, haptic: haptic, completion: completion)
        alert.present()
    }
    
    
    
}

enum NotifyType: String { case success, info, warning, error }
/// Модальное представление уведомления
private class NotificationViewAlert: UIView {
    //MARK: - Properies -
    private let formView = UIView(color: .fSuccess)
    private let titleLabel = UILabel(font: .boldSystemFont(ofSize: 12), color: .fBluishBlack, lines: 0)
    private let descLabel = UILabel(font: .systemFont(ofSize: 12), color: .fBluishBlack, lines: 0)
    private let imageView = UIImageView().size(width: 24, height: 24)
    private let closeButton = UIButton().size(width: 24, height: 24)
    private var delay: TimeInterval = 2.0
    private var haptic: UINotificationFeedbackGenerator.FeedbackType = .success
    private var completion: (()->Void)?
    private var dissmisFromGesture: Bool = false
    private var type: NotifyType = .info

    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String = "Opps...",
                     message: String = "",
                     type: NotifyType = .info,
                     delay: TimeInterval = 2,
                     haptic: UINotificationFeedbackGenerator.FeedbackType = .success,
                     completion: (()->Void)? = nil) {
        self.init()
        titleLabel.text = title
        descLabel.text = message
        self.delay = delay
        self.haptic = haptic
        self.completion = completion
        switch type {
        case .success:
            imageView.image = .img_success
            formView.backgroundColor = .fSuccess
        case .info:
            imageView.image = .img_info
            formView.backgroundColor = .fInfo
        case .warning:
            imageView.image = .img_warning
            formView.backgroundColor = .fWarning
        case .error:
            imageView.image = .img_error
            formView.backgroundColor = .fError
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadow(for: formView)
        layoutIfNeeded()
    }
    
    
    // MARK: - Helpers -
    @objc public func present() {
        guard let window = UIApplication.shared.windows.first else {return}
        window.addSubview(self)
        window.bringSubviewToFront(self)
        autoresizingMask = [.flexibleWidth]
        let height = titleLabel.requiredHeight + 30 + descLabel.requiredHeight
        frame = CGRect(x: 0, y: -height, width: window.frame.width, height: height)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height*2)
        }
        Haptic.notification(haptic)
        perform(#selector(dismiss), with: nil, afterDelay: delay)
        titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.requiredHeight).isActive = true
        
    }
    
    private func setUp() {
        isUserInteractionEnabled = true
        addSubview(formView)
        formView.addSubview(titleLabel)
        formView.addSubview(descLabel)
        formView.addSubview(imageView)
        formView.addSubview(closeButton)
        closeButton.setImage(.btn_close, for: .normal)
        closeButton.contentMode = .left
        createConstraints()
        addSwipe()
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
    private func addSwipe() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handle(swipe:)))
        swipeUp.direction = .up
        addGestureRecognizer(swipeUp)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handle(swipe:)))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handle(swipe:)))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)
    }
    
    @objc private func handle(swipe: UISwipeGestureRecognizer) {
        var offsetPoint: CGPoint = CGPoint(x: 0, y: -bounds.height - 30)
        switch  swipe.direction {
        case .left: offsetPoint = CGPoint(x: -frame.width, y: 0)
        case .right: offsetPoint = CGPoint(x: +frame.width, y: 0)
        default: break
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.frame = CGRect(x: offsetPoint.x, y: offsetPoint.y, width: self.frame.width, height: self.bounds.height)
            self.completion?()
        } completion: { _ in
            self.dissmisFromGesture = true
            self.removeFromSuperview()
        }
        
    }
    
    @objc func dismiss() {
        if superview != nil {
            UIView.animate(withDuration: 0.3) {
                self.alpha = 0
                if !self.dissmisFromGesture {
                    self.completion?()
                }
            } completion: { _ in
                self.removeFromSuperview()
            }
        }
    }
    
    private func createConstraints() {
        formView.pinTo(self, edges: .centerX(0), .safeTop(10)).width(self, equalTo: .width, multiplier: 0.91)
        imageView.pinTo(formView, edges: .left(16), .centerY)
        closeButton.pinTo(formView, edges: .right(16), .centerY)
        titleLabel.pinTo(formView, edges: .top(12), .right(46))
        descLabel.pinTo(formView, edges: .bottom(12), .right(46))
        imageView.pinTo(titleLabel, edges: .spaceH(16))
        titleLabel.pinTo(descLabel, edges: .spaceV(2))
        descLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    }
    
    fileprivate func dropShadow(for view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
        view.layer.shadowPath = CGPath(roundedRect: view.bounds, cornerWidth: 10, cornerHeight: 10, transform: nil)
    }
    
}

extension UIColor {
    static let fSuccess = UIColor(hex: "#EAFAE6")!
    static let fWarning = UIColor(hex: "#FFEEE9")!
    static let fError = UIColor(hex: "#FCEBF5")!
    static let fInfo = UIColor(hex: "#ECEEF8")!
}

extension UIImage {
    static let img_info = UIImage(named: "img_info")!
    static let img_success = UIImage(named: "img_success")!
    static let img_warning = UIImage(named: "img_warning")!
    static let img_error = UIImage(named: "img_error")!
    static let btn_close = UIImage(named: "btn_close")!
}
