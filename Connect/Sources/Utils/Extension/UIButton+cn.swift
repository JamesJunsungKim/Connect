
//
//  UIButton.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIButton {
    
    open override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .mainBlue : .lightGray
            alpha = isEnabled ? 1 : 0.5
        }
    }
    
    // MARK: - Public / Internal
    
    public func setTitleWhileKeepingAttributes(title:String) {
        if let attributedTitle = currentAttributedTitle {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: title)
            self.setAttributedTitle(mutableAttributedTitle, for: .normal)
        }
    }
    
    
    // MARK: - static
    public static func create(title: String, titleColor: UIColor = .black, fontSize: CGFloat = 10, backgroundColor: UIColor = .clear) -> UIButton {
        let bt = UIButton(type: .system)
        bt.backgroundColor = backgroundColor
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor:titleColor, NSAttributedStringKey.font: UIFont.mainFont(size: fontSize)])
        bt.setAttributedTitle(attributedString, for: .normal)
        return bt
    }
    
    public static func create(withImageName imageName: String) -> UIButton {
        let bt = UIButton(type: .system)
        let img = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        bt.setImage(img, for: .normal)
        bt.backgroundColor = .clear
        return bt
    }
    
    public static func create(withImage image: UIImage) -> UIButton {
        let bt = UIButton(type: .system)
        bt.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        bt.backgroundColor = .clear
        return bt
    }
    
    
}


