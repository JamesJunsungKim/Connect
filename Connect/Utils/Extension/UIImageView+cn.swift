//
//  UIImageView.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func fitTo(size: CGSize) {
        self.frame = CGRect(x: frame.minX, y: frame.minY, width: size.width, height: size.height)
    }
    
    public func setImage(with image: UIImage) {
        self.image = image
    }
    
    // MARK: - Static
    public static func create(image: UIImage) -> UIImageView {
        let iv = UIImageView()
        iv.image = image
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }
    
    
}
