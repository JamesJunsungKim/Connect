//
//  Sequence.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension Sequence {
    public func asyncForEach(completion:@escaping ()->(), block:(Iterator.Element, @escaping()->())->()) {
        let group = DispatchGroup()
        let innerCompletion = {group.leave()}
        for x in self {
            group.enter()
            block(x, innerCompletion)
        }
        group.notify(queue: DispatchQueue.main, execute: completion)
    }
    
    public func all(_ condition: (Iterator.Element)->Bool) -> Bool {
        for x in self where !condition(x) {
            return false
        }
        return true
    }
    
    public func some(_ condition:(Iterator.Element)->Bool) ->Bool {
        for x in self where condition(x) {
            return true
        }
        return false
    }
}

extension Sequence where Iterator.Element: AnyObject {
    public func containsObjectIdentical(to object: AnyObject) -> Bool {
        return contains { ($0 as AnyObject) === object }
    }
}









