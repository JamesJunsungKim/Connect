//
//  Group.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData

final class Group: NSManagedObject {
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var createdAt: Date
    
    @NSManaged fileprivate(set) var members: Set<User>
    
    
    // MARK: - Fileprivate
    
    
}


extension Group: Managed {
    
}
