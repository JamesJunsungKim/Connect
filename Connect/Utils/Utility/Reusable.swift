//
//  Reusable.swift
//  Connect
//
//  Created by James Kim on 5/23/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

protocol Reusable {}

extension Reusable {
    static var reuseIdentifier: String {
        let className = NSStringFromClass(self as! (AnyClass)).components(separatedBy: ".")[1]
        return className
    }
}
