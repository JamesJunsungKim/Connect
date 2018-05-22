//
//  UITextField.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UITextField {
    
    func validateForEmail() -> Bool {
        let arg = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", arg)
        return predicate.evaluate(with: text!)
    }
    
    func validateForNumber() -> Bool {
        let arg = "^[0-9]+(\\.[0-9]+)?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", arg)
        return predicate.evaluate(with: text!)
    }
    
    func validateIfHasTextAndMakeBorderColored(with color: UIColor)-> Bool {
        if hasText {
            makeBorder(color: .black, width: 0)
            return true
        } else {
            makeBorder(color: .red)
            return false
        }
    }
    
    func makeBorder(color: UIColor, width: CGFloat = 1.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    
    
    // MARK: static funcs
    
    public static func create(placeHolder: String, textSize: CGFloat = 10, textColor: UIColor = .black, borderColor: UIColor = .blue, keyboardType: UIKeyboardType = .default) -> UITextField {
        let tf = UITextField()
        tf.textColor = textColor
        tf.placeholder = placeHolder
        tf.makeBorder(color: borderColor == .blue ? .mainBlue: borderColor)
        tf.setCornerRadious(value: 3)
        tf.font = UIFont.mainFont(size: textSize)
        tf.keyboardType = keyboardType
        return tf
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
