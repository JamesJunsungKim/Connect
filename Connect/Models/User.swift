//
//  User.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData

final class User: NSManagedObject {
    @NSManaged fileprivate(set) var id: String
    @NSManaged fileprivate(set) var name: String?
    @NSManaged fileprivate(set) var phoneNumber: NSNumber?
    @NSManaged fileprivate(set) var isFavorite: Bool
    @NSManaged fileprivate(set) var emailAddress: String
    
    @NSManaged fileprivate(set) var contacts: Set<User>?
    @NSManaged fileprivate(set) var profilePhoto: Photo?
    @NSManaged fileprivate(set) var groups: Set<Group>?
    
    
    // MARK: - Fileprivate
    
    
}


extension User: Managed {
    
}
