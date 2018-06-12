//
//  UITextView+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/29/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UITextView {
    
    // MARK: - Public/Internal
    
    
    // MARK: - static
    public static func estimateFrameForText(cellWidth:CGFloat, forText text: String) ->CGRect {
        let size = CGSize(width: cellWidth, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: UIFont.mainFont(size: 16)], context: nil)
    }
    
    internal static func create(text:String, mainFontSize:CGFloat?, customFont: UIFont? = nil, textColor: UIColor = .black, backgroundColor: UIColor = .white, textAlignment: NSTextAlignment = .left, isEditable: Bool = false, isScrollEnabled:Bool = false, attributedText: NSAttributedString? = nil)-> UITextView {
        let tv = UITextView()
        tv.text = text
        tv.backgroundColor = backgroundColor
        tv.font = customFont != nil ? customFont! : UIFont.mainFont(size: mainFontSize!)
        tv.textAlignment = textAlignment
        tv.isScrollEnabled = isScrollEnabled
        tv.textColor = textColor
        tv.isEditable = isEditable
        if attributedText != nil {tv.attributedText = attributedText!}
        return tv
    }
    
}
