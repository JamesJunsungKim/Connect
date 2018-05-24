//
//  UIView.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIView {
    public func getParentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as? UIViewController
            }
        }
        return nil
    }
    
    public func setCornerRadious(value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
    
    public func setBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    public func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
    // MARK: - static
    
    public static func create(withColor color: UIColor = .lightGray) -> UIView {
        let v = UIView()
        v.backgroundColor = color
        return v
    }
}
