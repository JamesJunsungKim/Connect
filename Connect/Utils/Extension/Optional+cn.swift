//
//  Optional.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension Optional {
    public func unwrapOr<T>(defaultValue:T)->T {
        if let r = self as? T{
            return r
        } else {
            return defaultValue
        }
    }
    public func unwrapOrNull()->Any {
        return unwrapOr(defaultValue: (NSNull() as Any))
    }
}

extension Optional where Wrapped == String {
    public func unwrapOrBlank()->String {
        return unwrapOr(defaultValue: "")
    }
}

extension Optional where Wrapped == Bool {
    public func unwrapOrFalse() -> Bool {
        return unwrapOr(defaultValue: false)
    }
}


