//
//  DictionaryCreatable.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

protocol DictionaryCreatable {}

extension DictionaryCreatable {
    public static func createObjectDictionary() -> [Int:[Self]] {
        return [:]
    }
}
