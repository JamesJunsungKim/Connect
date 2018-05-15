//
//  Managed.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData

public protocol Managed: AnyObject, NSFetchRequestResult {
    static var entity: NSEntityDescription {get}
    static var entityName: String {get}
    static var defaultSortDescriptors: [NSSortDescriptor] {get}
    static var defaultPredicate: NSPredicate{get}
    var managedObjectContext: NSManagedObjectContext? {get}
}

public protocol DefaultManaged: Managed{}

extension DefaultManaged {
    public static var defaultPredicate: NSPredicate {
        return NSPredicate(value: true)
    }
}


extension Managed {
    
    public static var defaultSortDescriptors: [NSSortDescriptor] { return [] }
    public static var defaultPredicate: NSPredicate { return NSPredicate(value: true) }
    
    public static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        request.predicate = defaultPredicate
        return request
    }
    
    public static func sortedFetchRequest(with predicate: NSPredicate) -> NSFetchRequest<Self> {
        let request = sortedFetchRequest
        guard let existingPredicate = request.predicate else {fatalError("must have predicate")}
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [existingPredicate, predicate])
        return request
    }
    
    public static func predicate(format: String, _ args: CVarArg...)->NSPredicate {
        let p = withVaList(args, {NSPredicate(format: format, arguments: $0)})
        return predicate(p)
    }
    
    public static func predicate(_ predicate: NSPredicate)->NSPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: [defaultPredicate, predicate])
    }
    
}

extension Managed where Self:NSManagedObject {
    public static var entity: NSEntityDescription { return entity() }
    public static var entityName: String {
        guard let name = entity.name else {fatalError("must have entity name")}
        return name
    }
    
    public static func deleteAll(fromMOC context: NSManagedObjectContext) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
        } catch let error{
            logError(error.localizedDescription)
        }
    }
    
    public static func findOrCreate(in context: NSManagedObjectContext, matching predicate: NSPredicate, configure:(Self)->())->Self {
        if let obj = findOrFetch(in: context, matching: predicate) {
            return obj
        } else {
            let newObj: Self = context.insertObject()
            configure(newObj)
            return newObj
        }
    }
    
    public static func findOrFetch(in context: NSManagedObjectContext, matching predicate: NSPredicate)->Self? {
        if let obj = materializedObject(in: context, matching: predicate) {
            return obj
        } else {
            return fetch(in: context) { (request) in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
            }.first
        }
    }
    
    public static func fetch(in context: NSManagedObjectContext, configurationBlock:(NSFetchRequest<Self>)->() = {_ in }) -> [Self] {
        let request = NSFetchRequest<Self>(entityName: entityName)
        configurationBlock(request)
        return try! context.fetch(request)
    }
    
    public static func count(in context: NSManagedObjectContext, configure: (NSFetchRequest<Self>)->() = {_ in }) ->Int {
        let request = NSFetchRequest<Self>(entityName: entityName)
        configure(request)
        return try! context.count(for: request)
    }
    
    public static func materializedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        for obj in context.registeredObjects where !obj.isFault {
            guard let result = obj as? Self, predicate.evaluate(with: result) else {continue}
            return result
        }
        return nil
    }
}










