//
//  ConstraintMaker.swift
//  Connect
//
//  Created by James Kim on 5/29/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import SnapKit

extension ConstraintMaker {
    public func sizeEqualTo(width:CGFloat, height:CGFloat) {
        self.size.equalTo(CGSize(width: width, height: height))
    }
    
    public func leftRightEqualToSuperView(withOffset value: CGFloat) {
        self.left.equalToSuperview().offset(value)
        self.right.equalToSuperview().offset(-value)
    }
    
    public func topBottomEqualToSuperView(withOffset value: CGFloat) {
        self.top.equalToSuperview().offset(value)
        self.bottom.equalToSuperview().offset(-value)
    }
}

