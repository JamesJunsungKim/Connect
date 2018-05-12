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
import Firebase

final class User: NSManagedObject, BaseModel {
    
    @NSManaged fileprivate(set) var uid: String?
    @NSManaged fileprivate(set) var name: String
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
    
    
    
    // MARK: - Static
    public static func create(into moc: NSManagedObjectContext, name: String, email: String, isOnwer: Bool) {
        let user: User = moc.insertObject()
        user.name = name
        user.emailAddress = email
        user.isOwner = isOnwer
    }
    
    public static func createAndRegister(into moc: NSManagedObjectContext, name:String, email: String, password: String, completion:@escaping (User)->(), failure:@escaping (Error)->()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user_, error) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
//            user.id = user_!.uid
//            completion(user)
        }
        
    }
    
    
    // MARK: - Fileprivate
    
    @NSManaged fileprivate var primitiveIsFavorite: Bool
    
    
    
}

extension User {
    
}


extension User: Managed {
    
}





















