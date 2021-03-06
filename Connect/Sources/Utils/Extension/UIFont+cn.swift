//
//  UIFont.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIFont {
    enum Key : String {
        case helveticaNeue = "HelveticaNeue"
        case helveticaNeueInBold = "HelveticaNeue-Bold"
    }
    
    // MARK: - Public
    
    public func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    public func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
    // MARK: - Static
    internal static func mainFont(size:CGFloat, shouldBold flag: Bool = false)->UIFont {
        let font = UIFont(name:"Avenir Next", size: size)!
        return flag ? font.bold() : font
    }
    
    internal static func create(forKey key: Key, size: CGFloat) -> UIFont {
        return UIFont(name: key.rawValue, size: size)!
    }
    
    // MARK: - Filepriavte
    
    fileprivate func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    
}
