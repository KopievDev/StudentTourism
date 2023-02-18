//
//  BaseView.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

class BaseView: UIView {
    var closeKeyboardGesture:UITapGestureRecognizer!;
    @IBOutlet var bottomConstraintForKeyboard: NSLayoutConstraint?
    @IBOutlet var backBtnWidthConstraint: NSLayoutConstraint?
    var popup: PopupView? {
        didSet { bindPopUp() }
    }
    public var getState: () -> [String:Any] = { [:] }

    var state: [String: Any] { getState() }

    override func awakeFromNib() {
        super.awakeFromNib()
        closeKeyboardGesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard));
        startKeyboardHidingMechanism()
        customizeUI()
    }

    func startKeyboardHidingMechanism() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func bindPopUp() {
        hideKeyboard()
        popup?.didClose = { [weak self] in self?.popup = nil }
    }
    
    @objc func hideKeyboard() { endEditing(true) }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard popup?.statePopUp == .dismissed || popup == nil else { return }
        if !(self.gestureRecognizers?.contains(closeKeyboardGesture) ?? false) {
            self.addGestureRecognizer(closeKeyboardGesture);
        }
        if let bottomConstraintForKeyboard = bottomConstraintForKeyboard {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                bottomConstraintForKeyboard.constant = keyboardSize.height;
                self.layoutIfNeeded();
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification){
        if (self.gestureRecognizers?.contains(closeKeyboardGesture) ?? false) {
            self.removeGestureRecognizer(closeKeyboardGesture);
        }
        if let bottomConstraintForKeyboard = bottomConstraintForKeyboard {
            bottomConstraintForKeyboard.constant = 0;
            self.layoutIfNeeded();
        }
    }

    func customizeUI() {}

    func render() {}

    deinit { NotificationCenter.default.removeObserver(self) }
}
