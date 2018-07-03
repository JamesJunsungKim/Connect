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
    
    public func blurImage() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    public func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    
    // MARK: - Static
    public static func create(withImageName imageName: String) -> UIImageView {
        let iv = UIImageView()
        let image = UIImage(named: imageName)
        iv.image = image
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }
    
    public static func create(withImage image: UIImage, contentMode: UIViewContentMode = .scaleAspectFit) -> UIImageView {
        let iv = UIImageView()
        iv.image = image
        iv.isUserInteractionEnabled = true
        iv.contentMode = contentMode
        iv.clipsToBounds = true
        return iv
    }
    
    internal static func create(withImageKey key: UIImage.Name) -> UIImageView {
        return create(withImage: UIImage.create(forKey: key))
    }
    
    internal static func create(withBackgroundColor color: UIColor = .clear) ->UIImageView {
        let i = create(withImage: UIImage())
        i.backgroundColor = color
        return i
    }
}








