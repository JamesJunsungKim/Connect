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
    
    func validateIfHasTextAndMakeBorderColored()-> Bool {
        if hasText {
            makeBorderBlack()
            return true
        } else {
            makeBorderRed()
            return false
        }
    }
    
    func makeBorderRed(width: CGFloat = 1.0) {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = width
    }
    
    func makeBorderBlack(width: CGFloat = 0) {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = width
    }
    
    
    
    // MARK: static funcs
    
    public static func create(placeHolder: String, textSize: CGFloat = 10, color: UIColor = .black, keyboardType: UIKeyboardType = .default) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeHolder
        tf.font = UIFont.mainFont(size: textSize)
        tf.keyboardType = keyboardType
        return tf
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
