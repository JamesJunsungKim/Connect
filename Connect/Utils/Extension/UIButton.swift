
//
//  UIButton.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIButton {
    public static func create(title: String, isTextBold:Bool = false ,titleColor: UIColor = .black, fontSize: CGFloat = 10, backgroundColor: UIColor = .clear) -> UIButton {
        let bt = UIButton(type: .system)
        bt.backgroundColor = backgroundColor
        let attributedString = NSAttributedString(string: title, attributes: <#T##[NSAttributedStringKey : Any]?#>)
        [NSAttributedStringKey.foregroundColor:titleColor, NSAttributedStringKey.font: UIFont.mainFont(size: fontSize)]
//        bt.setAttributedTitle(<#T##title: NSAttributedString?##NSAttributedString?#>, for: <#T##UIControlState#>)
        return bt
        
    }
}
