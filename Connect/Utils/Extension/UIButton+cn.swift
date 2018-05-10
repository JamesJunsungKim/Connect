
//
//  UIButton.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIButton {
    public static func create(title: String,titleColor: UIColor = .black, fontSize: CGFloat = 10, backgroundColor: UIColor = .clear) -> UIButton {
        let bt = UIButton(type: .system)
        bt.backgroundColor = backgroundColor
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor:titleColor, NSAttributedStringKey.font: UIFont.mainFont(size: fontSize)])
        bt.setAttributedTitle(attributedString, for: .normal)
        return bt
    }
    
    open override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .mainBlue : .lightGray
            alpha = isEnabled ? 1 : 0.5
        }
    }
    
    
    
}
