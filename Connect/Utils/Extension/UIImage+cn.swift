//
//  UIImage.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIImage {
    
    public var jpegData: Data {
        guard let result = UIImageJPEGRepresentation(self, UserDefaults.retrieveValue(forKey: .imageResolution, defaultValue: 20)) else {fatalError("Cannot convert it into data")}
        return result
    }
    
    public var pngData: Data? {
        return UIImagePNGRepresentation(self)
    }
    
    func resizeImage(scale: CGFloat) -> UIImage {
        let newSize = CGSize(width: self.size.width*scale, height: self.size.height*scale)
        let rect = CGRect(origin: CGPoint.zero, size: newSize)
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func withAlpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    // MARK: - Static
    
    
    
    
    
}
