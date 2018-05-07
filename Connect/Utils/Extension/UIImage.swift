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
    
    
    
    
    
    
    
    
    
    
    
}
