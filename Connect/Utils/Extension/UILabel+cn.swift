//
//  UILabel.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UILabel {
    
    static public func create(text: String, textAlignment:NSTextAlignment = .left, textColor: UIColor = .black ,fontSize: CGFloat = 10, numberofLine: Int = 0) -> UILabel {
        let lb = UILabel()
        lb.textAlignment = textAlignment
        lb.text = text
        lb.textColor = textColor
        lb.font = UIFont.mainFont(size: fontSize)
        lb.numberOfLines = numberofLine
        return lb
    }
    
    
    
    
}
