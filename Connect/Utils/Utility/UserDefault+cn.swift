//
//  UserDefault.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum Key : String {
        case defaultResolution
        case uidForSignedInUser
    }
    
    
    // MARK: - Static
    static func userRequestToSignOut() {
        let keys:[UserDefaults.Key] = [.uidForSignedInUser]
        keys.forEach({UserDefaults.removeValue(forKey: $0)})
    }
    
    static func retrieveValue<T>(forKey key: Key, defaultValue:T) -> T {
        return checkIfValueExist(forKey: key) ? UserDefaults.standard.object(forKey: key.rawValue) as! T : defaultValue
    }
    
    static func retrieveValueOrFatalError(forKey key: Key)->Any {
        return UserDefaults.standard.object(forKey: key.rawValue)!
    }
    
    static func store(object: Any, forKey key: Key) {
        UserDefaults.standard.setValue(object, forKey: key.rawValue)
    }
    
    static func removeValue(forKey key: Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    static func checkIfValueExist(forKey key: Key)->Bool {
        return UserDefaults.standard.object(forKey: key.rawValue) != nil
    }
    
}
