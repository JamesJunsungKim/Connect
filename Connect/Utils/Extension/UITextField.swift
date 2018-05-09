//
//  UITextField.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UITextField {
    
    func validateForEmail()->Bool {
        let arg = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", arg)
        if !predicate.evaluate(with:self.text!) {
            isNotValid()
            return false
        } else {
            resetValidation()
            return true
        }
    }
    
    func validateIfHasText()-> Bool {
        if hasText {
            resetValidation()
            return true
        } else {
            isNotValid()
            return false
        }
    }
    
    func isNotValid() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1.0
    }
    
    func resetValidation() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.0
    }
    
    public static func create(placeHolder: String, textSize: CGFloat = 10, color: UIColor = .black, keyboardType: UIKeyboardType = .default) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeHolder
        tf.font = UIFont.mainFont(size: textSize)
        tf.keyboardType = keyboardType
        return tf
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
