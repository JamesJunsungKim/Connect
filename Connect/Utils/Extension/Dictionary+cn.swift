//
//  Dictionary.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension Dictionary where Key == Int {
    public func updateObject(atSection section: Int, withData data:Value)->[Int:Value] {
        var dict = self
        dict[section] = data
        return dict
    }
}

extension Dictionary where Key == String {
    public func checkIfValueExists(forKey key: String) -> Bool {
        return self[key] != nil
    }
}

extension Dictionary where Key == String, Value == Any {
    public func addValueIfNotEmpty<A>(forKey key: String, value: A?, configuration: ((A)->Any)? = nil)-> Dictionary {
        var dict = self
        if value != nil {
            dict[key] = configuration != nil ? configuration!(value!): value!
        }
        return dict
    }
}

extension Dictionary where Value == Any {
    func value<T>(forKey key: Key, defaultValue: @autoclosure ()->T)->T {
        if let value = self[key] as? T {
            return value
        } else {
            return defaultValue()
        }
    }
}



