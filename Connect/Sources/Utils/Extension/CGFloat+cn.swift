//
//  CGFloat+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 6/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension CGFloat {
    
    // MARK: - Public
    public func convertToString(maximumFractionDigits:Int = 2)->String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter.string(from: NSNumber(value: Float(self)))!
    }
}
