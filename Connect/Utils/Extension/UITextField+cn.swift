//
//  UITextField.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UITextField {
    
    
    
    func validateIfHasTextAndMakeBorderColored(with color: UIColor)-> Bool {
        if hasText {
            self.setBorder(color: .black, width: 0)
            return true
        } else {
            self.setBorder(color: .red, width: 0.5)
            return false
        }
    }
    
    
    // MARK: static funcs
    
    public static func create(placeHolder: String, textSize: CGFloat = 10, textColor: UIColor = .black, keyboardType: UIKeyboardType = .default) -> UITextField {
        let tf = UITextField()
        tf.textColor = textColor
        tf.placeholder = placeHolder
        tf.font = UIFont.mainFont(size: textSize)
        tf.keyboardType = keyboardType
        return tf
    }
    
    
    
    
    
    
    
    
    
    
}
