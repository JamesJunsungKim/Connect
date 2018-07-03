//
//  Dictionary.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension Dictionary {
    func cn_keyvalues() -> [[String:Any]] {
        return self.keys.map({["key": $0, "value": self[$0]!]})
    }
    func cn_sortedKeyValues() -> [[String:Any]] {
        let sortByKey = NSSortDescriptor(key: "key", ascending: true)
        return (self.cn_keyvalues() as NSArray).sortedArray(using: [sortByKey]) as! [[String : Any]]
    }
}

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



