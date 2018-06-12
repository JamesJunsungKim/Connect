//
//  UidFetchable.swift
//  Connect
//
//  Created by James Kim on 6/2/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData

protocol UidFetchable {}

extension UidFetchable where Self:NSManagedObject & Managed {
    internal static func findOrFetch(forUID uid: String, fromMOC moc: NSManagedObjectContext) -> Self? {
        let predicate = NSPredicate(format: "uid == %@", uid)
        return Self.findOrFetch(in: moc, matching: predicate)
    }
}
