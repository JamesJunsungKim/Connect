//
//  CGSize.swift
//  Connect
//
//  Created by James Kim on 6/2/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension CGSize {
    public func extend(widthBy: CGFloat, heightBy: CGFloat) -> CGSize {
        return CGSize(width: self.width + widthBy, height: self.height + heightBy)
    }
    
    
    
    
}
