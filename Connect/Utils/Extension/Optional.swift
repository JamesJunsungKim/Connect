//
//  Optional.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension Optional {
    func unwrapOr<T>(defaultValue:T)->T {
        if let r = self as? T{
            return r
        } else {
            return defaultValue
        }
    }
    func unwrapOrNull()->Any {
        return unwrapOr(defaultValue: NSNull())
    }
}

extension Optional where Wrapped == String {
    func unwrapOrBlank()->String {
        return unwrapOr(defaultValue: "")
    }
}

extension Optional where Wrapped == Bool {
    func unwrapOrFalse() -> Bool {
        return unwrapOr(defaultValue: false)
    }
}


