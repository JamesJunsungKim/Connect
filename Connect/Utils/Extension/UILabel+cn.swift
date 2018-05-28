//
//  UILabel.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UILabel {
    
    // MARK: - Public
    public func changeFont(to font: UIFont) {
        self.font = font
    }
    
    // MARK: - Static
    static public func create(text: String, textAlignment:NSTextAlignment = .left, textColor: UIColor = .black ,fontSize: CGFloat = 10, boldFont flag: Bool = false, numberofLine: Int = 0) -> UILabel {
        let lb = UILabel()
        lb.textAlignment = textAlignment
        lb.text = text
        lb.textColor = textColor
        lb.font = UIFont.mainFont(size: fontSize, shouldBold: flag)
        lb.numberOfLines = numberofLine
        return lb
    }
    
    
    
    
}
