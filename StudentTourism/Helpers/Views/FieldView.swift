//
//  FieldView.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 18.02.2023.
//

import UIKit

class FieldView: UIView {
    @IBOutlet var textField: UITextField!
    @IBOutlet var placeholderLabel: UILabel!
    @IBOutlet var placeCenterCnstr: NSLayoutConstraint!
    @IBOutlet var textFieldCenterCnstr: NSLayoutConstraint!
    @IBInspectable var isPrice: Bool = false
    var didTapReturn: VoidBlock?

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    func set(text: String) {
        placeCenterCnstr.constant = text.isEmpty ? 0:-textField.frame.height/2 - 4
        textFieldCenterCnstr.constant = text.isEmpty ? 0:6
        placeholderLabel.font = .systemFont(ofSize: text.isEmpty ? 16:13)
        UIView.animate(withDuration: 0.3) { self.layoutIfNeeded() }
        if isPrice {
            let price = Float(textField.text?.filter { $0.isNumber } ?? "0")?.currency(fractionDigits: 0)
            textField.text = price
        } else {
            textField.text = text
        }
        
    }

}

extension FieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapReturn?()
        return true
    }
}

extension Float {
    func currency(fractionDigits: Int = 0) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self))
    }
    
}
