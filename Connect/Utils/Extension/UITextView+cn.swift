//
//  UITextView+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/29/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UITextView {
    
    // MARK: - static
    
    internal static func create(text:String, mainFontSize:CGFloat?, customFont: UIFont? = nil, textColor: UIColor = .black, backgroundColor: UIColor = .clear, textAlignment: NSTextAlignment = .left, isEditable: Bool = false, attributedText: NSAttributedString? = nil)-> UITextView {
        let tv = UITextView()
        tv.text = text
        tv.backgroundColor = backgroundColor
        tv.font = customFont != nil ? customFont! : UIFont.mainFont(size: mainFontSize!)
        tv.textAlignment = textAlignment
        tv.textColor = textColor
        tv.isEditable = isEditable
        if attributedText != nil {tv.attributedText = attributedText!}
        return tv
    }
    
}
