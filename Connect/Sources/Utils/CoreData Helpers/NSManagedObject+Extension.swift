//
//  NSManagedObject+Extension.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData

extension NSManagedObject {
    public func refresh(_ mergeChanges: Bool = true) {
        managedObjectContext?.refresh(self, mergeChanges: mergeChanges)
    }
    
    public func changedValue(forKey key: String)->Any? {
        return changedValues()[key]
    }
    
    public func committedValue(forKey key: String)->Any? {
        return committedValues(forKeys: [key])[key]
    }
}
