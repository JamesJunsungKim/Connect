//
//  CoreDataTestHelper.swift
//  ConnectTests
//
//  Created by James Kim on 6/2/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData
@testable import Connect

extension NSManagedObjectContext {
    public func performChangesAndWait(_ b: @escaping ()->()) {
        performAndWait {
            b()
            try! self.save()
        }
    }
    
    static func connectInMemryTestContext() -> NSManagedObjectContext {
        return connectTestContext({$0.addInMemoryTestStore()})
    }
    
    static func connectSQLiteTestContext()->NSManagedObjectContext {
        return connectTestContext({$0.addSQLiteTestStore()})
    }
    
    fileprivate static func connectTestContext(_ addStore: (NSPersistentStoreCoordinator)->())->NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        addStore(coordinator)
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }
}
extension NSPersistentStoreCoordinator {
    
    fileprivate func addInMemoryTestStore() {
        try! addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    }
    
    fileprivate func addSQLiteTestStore() {
        let storeURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("connect-test")
        if FileManager.default.fileExists(atPath: storeURL.path) {
            try! destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
        }
        try! addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
    }
}

extension Managed where Self:NSManagedObject {
    public func materializedObject(in context: NSManagedObjectContext) -> Self {
        var result: Self!
        context.performAndWait {
            result = (context.object(with: self.objectID) as! Self).materialize()
        }
        return result
    }
    
    public func materialize() -> Self {
        for property in entity.properties {
            if let relationship = (self as NSManagedObject).value(forKey: property.name) as? Set<NSManagedObject> {
                let _ = relationship.count
            }
        }
        return self
    }
}
