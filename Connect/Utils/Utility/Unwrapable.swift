//
//  Unwrapable.swift
//  Connect
//
//  Created by James Kim on 5/15/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

protocol Unwrapable {}

extension Unwrapable {
    static func unwrapFrom(userInfo: [String:Any]) -> Self {
        let className = String(describing: Self.self)
        return (userInfo[className] as! Self)
    }
}
