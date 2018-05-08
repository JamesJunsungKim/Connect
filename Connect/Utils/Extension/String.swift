//
//  String.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation


extension String {
    
    func removingCharacters(in set: CharacterSet) -> String {
        var chars = Substring(self)
        for idx in chars.indices.reversed() {
            if set.contains(String(chars[idx]).unicodeScalars.first!) {
                chars.remove(at: idx)
            }
        }
        return String(chars)
    }
    
    public func convertToCharacterSet()-> CharacterSet {
        return CharacterSet(charactersIn: self)
    }
}
