//
//  UserDefault.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultKey : String {
        case imageResolution
    }
    
    static func retrieveValue<T>(forKey key: UserDefaultKey, defaultValue:T) -> T {
        return checkIfValueExist(forKey: key) ? UserDefaults.standard.object(forKey: key.rawValue) as! T : defaultValue
    }
    
    static func store(object: Any, forKey key: UserDefaultKey) {
        UserDefaults.standard.setValue(object, forKey: key.rawValue)
    }
    
    static func removeValue(forKey key: UserDefaultKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    
    private static func checkIfValueExist(forKey key: UserDefaultKey)->Bool {
        return UserDefaults.standard.object(forKey: key.rawValue) != nil
    }
    
}
