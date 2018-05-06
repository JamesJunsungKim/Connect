//
//  NSManagedObjectContext+Extension.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    private var psc: NSPersistentStoreCoordinator {
        guard let psc = persistentStoreCoordinator else {fatalError("psc missing")}
        return psc
    }
    
    private var store: NSPersistentStore {
        guard let store = psc.persistentStores.first else {fatalError("no store")}
        return store
    }
    
    private var metaData: [String:AnyObject] {
        get {
            return psc.metadata(for: store) as [String:AnyObject]
        }
        set {
            performChanges {[unowned self] in
                self.psc.setMetadata(self.metaData, for: self.store)
            }
        }
    }
    
    public func insertObject<A:NSManagedObject>() -> A where A:Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("wrong type")
        }
        return obj
    }
    
    public func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    public func performSaveorRollback() {
        perform {
            _ = self.saveOrRollback()
        }
    }
    
    public func performChanges(block:@escaping ()->()) {
        perform {
            block()
            _ = self.saveOrRollback()
        }
    }
}

private let SingleObjectCacheKey = "SingeObjectCache"
private typealias SingleObjectCache = [String:NSManagedObject]

extension NSManagedObjectContext {
    public func set(_ object: NSManagedObject?, forSingleObjectCacheKey key:String) {
        var cache = userInfo[SingleObjectCacheKey].unwrapOr(defaultValue: [String:NSManagedObject]())
        cache[key] = object
        userInfo[SingleObjectCacheKey] = cache
    }
    
    public func object(forSingleObjectCacheKey key: String)->NSManagedObject? {
        guard let cache = userInfo[SingleObjectCacheKey] as? SingleObjectCache else {return nil}
        return cache[key]
    }
}




































