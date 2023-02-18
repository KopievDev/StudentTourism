//
//  Popup.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

enum PopupViewStyle {
    case center
    case bottom
    case position(CGRect)
    case bottomConstraint
}

class PopupView: UIView {
    enum StatePopup { case presented, dismissed }
    var didClose: (()->())?
    var statePopUp: StatePopup = .dismissed
    fileprivate var view: UIView?
    fileprivate var back: UIView?
    fileprivate var style: PopupViewStyle = .bottom
    fileprivate var bottomConstraint: NSLayoutConstraint?
    fileprivate var blurView: BlurView?
    
    @discardableResult
    static func show(container: UIView, style: PopupViewStyle = .bottom, toSafeArea: Bool = true, withBlur: Bool = false) -> PopupView {
        container.endEditing(true)
        let popup = PopupView(frame: UIScreen.main.bounds)
        popup.backgroundColor = UIColor.clear
        let v: UIView
        if withBlur {
            v = BlurView(radius: 3, color: .fDarkGray, colorAlpha: 0.4)
            v.frame = popup.bounds
            v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        } else {
            v = UIView(frame: popup.bounds)
            v.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        }
        v.alpha = 0
        popup.back = v
        popup.addSubview(v)
        
        let tap = UITapGestureRecognizer(target: popup, action: #selector(PopupView.tap(_:)))
        tap.delegate = popup
        popup.back?.addGestureRecognizer(tap)

        switch style {
        case .bottom, .bottomConstraint:
            let swipe = UISwipeGestureRecognizer(target: popup, action: #selector(PopupView.swipe(_ :)))
            swipe.direction = .down
            popup.addGestureRecognizer(swipe)
        default:
            break
        }

        popup.view = container
        popup.view?.layer.cornerRadius = container.layer.cornerRadius
        popup.style = style
        popup.addSubview(container)
        UIApplication.shared.keyWindow?.addSubview(popup)
        UIApplication.shared.keyWindow?.bringSubviewToFront(popup)
        
        var bottomPadding = CGFloat(0)
        if #available(iOS 11.0, *) {
            if toSafeArea { bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 }
        }

        switch style {
        case .center:
            if container.translatesAutoresizingMaskIntoConstraints {
                var frame = container.bounds
                frame.origin = CGPoint(x: (popup.bounds.width - frame.width)/2, y: (popup.bounds.height - frame.height)/2 )
                container.frame = frame
            } else {
                if let back = popup.back { container.pinTo(back, edges: .centerX,.centerY) }
            }
            UIView.animate(withDuration: 0.3) {
                v.alpha = 1
            }
        case .bottom:
            if container.translatesAutoresizingMaskIntoConstraints {
                var frame = container.bounds
                frame.origin = CGPoint(x: 0, y: popup.bounds.height)
                frame.size = CGSize(width: popup.bounds.width, height: frame.height)
                container.frame = frame
                frame.origin.y = popup.bounds.height - frame.height - bottomPadding
                if bottomPadding > 0 {
                    let fillView = UIView(cornerRadius: 0, color: .white)
                        .size(width: .width, height: bottomPadding+6)
                    v.addSubview(fillView, edges: .bottom, .centerX)
                }
                UIView.animate(withDuration: 0.3) {
                    v.alpha = 1
                    container.frame = frame
                }
            } else {
                if let back = popup.back {
                    container.pinTo(back, edges: .left, .bottom,.right)
                }
                UIView.animate(withDuration: 0.3) {
                    v.alpha = 1
                }
            }
           
      
        case .position(let frame):
            container.frame = frame
            container.alpha = 0
            UIView.animate(withDuration: 0.3) {
                v.alpha = 1
                container.alpha = 1
            }

        case .bottomConstraint:
            container.translatesAutoresizingMaskIntoConstraints = false
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addConstraint(view: popup, left: 0, right: 0, top: 0, bottom: 0)
            }

            popup.addConstraint(view: container, left: 0, right: 0, bottom: -container.frame.height)

            popup.layoutIfNeeded()

            container.setConstraint(bottom: 0)
            container.alpha = 0
            UIView.animate(withDuration: 0.3) {
                v.alpha = 1
                container.alpha = 1
                popup.layoutIfNeeded()
            }
        }
        popup.statePopUp = .presented
        return popup
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tap(_ recgnize: UIGestureRecognizer) {
        let point = recgnize.location(in: view)
        guard let rect = view?.bounds, !rect.contains(point) else { return }
        close(inside: true)
    }
    
    @objc func swipe(_ recgnize: UIGestureRecognizer) {
        let point = recgnize.location(in: view)
        if let view = view, view.bounds.contains(point) {
            if !canSwipe(view: view, point: point) {
                return
            }
        }
        close(inside: true)
    }
    
    func canSwipe(view: UIView, point: CGPoint) -> Bool {
        var can = true
        
        if let scroller = view as? UIScrollView, scroller.isScrollEnabled,
           scroller.frame.contains(point) {
            return false
        }
        
        if view.subviews.count > 0 {
            var i = 0
            while can && i < view.subviews.count {
                can = canSwipe(view: view.subviews[i], point: point)
                i += 1
            }
        }
        
        return can
    }
    
    func close(inside: Bool = false) {
        guard let container = view, let v = back else { return }
        var frame = container.bounds
        frame.origin.y = bounds.height

        container.setConstraint(bottom: -container.frame.height)

        UIView.animate(withDuration: 0.3, animations: {
            v.alpha = 0
            switch self.style {
            case .bottom: container.frame = frame
            case .bottomConstraint: self.layoutIfNeeded()
            default: container.alpha = 0
            }
        }) { (_) in
            container.removeFromSuperview()
            self.removeFromSuperview()
            if inside {
                self.didClose?()
            }
            self.statePopUp = .dismissed
        }
    }
    
    
    func setContainer(height: CGFloat, animation: Bool = true) {
        guard var frame = view?.frame else { return }
        frame.size.height = height
        var bottomPadding = CGFloat(0)
        if #available(iOS 11.0, *) {
            bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        frame.origin.y = bounds.height - frame.height - bottomPadding
        if animation {
            UIView.animate(withDuration: 0.3) {
                self.view?.frame = frame
            }
        } else {
            view?.frame = frame
        }
    }
}

extension PopupView: UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = touch.view?.superview else { return true}
        let t = String(describing: type(of: view))
        return t != "UITableViewCellContentView"
    }

}


extension CGFloat {
    static var width: CGFloat { UIScreen.main.bounds.width }
    static var height: CGFloat { UIScreen.main.bounds.height }
}
