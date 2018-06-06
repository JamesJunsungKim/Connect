//
//  Unwrapable.swift
//  Connect
//
//  Created by James Kim on 5/15/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

protocol Unwrappable {}

extension Unwrappable {
    static var className: String {
        return String(describing: Self.self)
    }
    
    public static func createObjectDictionary() -> [Int:[Self]] {
        return [:]
    }
    
    static func unwrapSingleInstanceFrom(userInfo: [String:Any]?) -> Self {
        return (userInfo![className] as! Self)
    }
    static func unwrapListFrom(userInfo: [String:Any]?) -> [Self] {
        return (userInfo![className] as! [Self])
    }
    
    static func createUserInfo(withObject object: Self) -> [String:Any] {
        return [Self.className:object]
    }
    
    static func createUserInfo(withList list: [Self]) -> [String:Any] {
        return [Self.className:list]
    }
}
