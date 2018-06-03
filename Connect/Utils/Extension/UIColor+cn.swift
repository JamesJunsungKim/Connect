//
//  UIColor.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func colorFromCode(_ code: Int) -> UIColor {
        let red = CGFloat((code & 0xFF0000) >> 16) / 255
        let green = CGFloat((code & 0xFF00) >> 8) / 255
        let blue = CGFloat(code & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func create(R: Int, G:Int, B:Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(R/255), green: CGFloat(G/255), blue: CGFloat(B/255), alpha: alpha)
    }
    
    /*
     Color adjusted for iOS's arbitrary lightening of navigation bar colors. 20 pts has been found to be accurate.
     */
    var navigationBarAdjusted: UIColor {
        let offset: CGFloat = 20/255
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return UIColor(red: r - offset, green: g - offset, blue: b - offset, alpha: a - offset)
    }
    
    static var eateryBlue: UIColor {
        return colorFromCode(0x437EC5)
    }
    
    static var mainBlue: UIColor {
        return eateryBlue
    }
    
    static var mainGray: UIColor {
        return UIColor.create(R: 85, G: 85, B: 85)
    }
    
    static var transparentEateryBlue: UIColor {
        return UIColor.eateryBlue.withAlphaComponent(0.8)
    }
    
    static var lightBackgroundGray: UIColor {
        return UIColor(white: 0.96, alpha: 1.0)
    }
    
    static var lightSeparatorGray: UIColor {
        return UIColor(white: 0.9, alpha: 1.0)
    }
    
    static var offBlack: UIColor {
        return colorFromCode(0x333333)
    }
    
    static var openGreen: UIColor {
        return colorFromCode(0x7ECC7E)
    }
    
    static var openTextGreen: UIColor {
        return UIColor(red:0.34, green:0.74, blue:0.38, alpha:1)
    }
    
    static var openYellow: UIColor {
        return UIColor(red:0.86, green:0.85, blue:0, alpha:1)
    }
    
    static var closedRed: UIColor {
        return UIColor(red:0.85, green:0.28, blue:0.25, alpha:1)
    }
    
    static var favoriteYellow: UIColor {
        return colorFromCode(0xF8E71C)
    }
    
    static var titleDarkGray: UIColor {
        return colorFromCode(0x7e7e7e)
    }
}

extension UIImage {
    static func image(withColor color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        
        color.setFill()
        
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
