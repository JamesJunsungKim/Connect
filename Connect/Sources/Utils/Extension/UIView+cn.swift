//
//  UIView.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: - Public/Internal
    
    public func getMostTopViewController() -> UIViewController? {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController!
        }
        return topVC
    }
    
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
    public static func create(withColor color: UIColor = .lightGray, alpha: CGFloat = 1) -> UIView {
        let v = UIView()
        v.backgroundColor = color
        v.alpha = alpha
        return v
    }
    
    public static func debugArea(target:[UIView]) {
        let debugColor: [UIColor] = [.red, .blue, .green, .magenta, .cyan, .orange, .brown, .mainBlue]
        guard target.count <= debugColor.count else {assertionFailure();return}
        
        for index in 0..<target.count {
            target[index].backgroundColor = debugColor[index]
        }
    }
    
    // MARK: - Fileprivate
}
