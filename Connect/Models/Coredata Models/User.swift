//
//  User.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
import FirebaseDatabase

final class User: NSManagedObject, BaseModel {
    
    @NSManaged fileprivate(set) var id: String
    @NSManaged fileprivate(set) var name: String?
    @NSManaged fileprivate(set) var phoneNumber: String?
    @NSManaged fileprivate(set) var emailAddress: String
    @NSManaged fileprivate(set) var isFavorite: Bool
    @NSManaged fileprivate(set) var isOwner: Bool
    
    @NSManaged fileprivate(set) var contacts: Set<User>?
    @NSManaged fileprivate(set) var profilePhoto: Photo?
    @NSManaged fileprivate(set) var groups: Set<Group>?
    
    static var dbReference: DatabaseReference {
        return FireDatabase.user.reference
    }
    
    override func awakeFromInsert() {
        primitiveIsFavorite = false
    }
    
    
    
    
    // MARK: - Fileprivate
    
    @NSManaged fileprivate var primitiveIsFavorite: Bool
    
    
    
}

extension User {
    
}


extension User: Managed {
    
}





















