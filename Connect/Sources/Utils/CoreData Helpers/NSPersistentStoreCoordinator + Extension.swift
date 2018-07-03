//
//  NSPersistentStoreCoordinator + Extension.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData

extension NSPersistentStoreCoordinator {
    // TODO(swift3) Migrate thise to NSPersistentContainer
    public static func destroyStore(at url: URL) {
        do {
            let psc = self.init(managedObjectModel: NSManagedObjectModel())
            try psc.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType, options: nil)
        } catch let e {
            print("failed to destroy persistent store at \(url)", e)
        }
    }
    
    // TODO(swift3) Migrate thise to NSPersistentContainer
    public static func replaceStore(at targetURL: URL, withStoreAt sourceURL: URL) throws {
        let psc = self.init(managedObjectModel: NSManagedObjectModel())
        try psc.replacePersistentStore(at: targetURL, destinationOptions: nil, withPersistentStoreFrom: sourceURL, sourceOptions: nil, ofType: NSSQLiteStoreType)
    }
}
