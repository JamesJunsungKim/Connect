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
    
    struct Key {
        static let user = "User"
        static let uid = "uid"; static let name = "name"
        static let phoneNumber = "phoneNumber";
        static let email = "emailAddress"
    }
    
    static var dbReference: DatabaseReference {
        return FireDatabase.user.reference
    }
    
    override func awakeFromInsert() {
        primitiveIsFavorite = false
    }
    
    // MARK: - Public
    
    public func setProfilePhoto(with photo: Photo) {
        profilePhoto = photo
    }
    
    
    // MARK: - Static
    public static func create(into moc: NSManagedObjectContext, name: String, email: String, isOnwer: Bool = false)->User {
        let user: User = moc.insertObject()
        user.name = name
        user.emailAddress = email
        user.isOwner = isOnwer
        return user
    }
    
    public static func createAndRegister(into moc: NSManagedObjectContext, name:String, email: String, password: String, completion:@escaping (User)->(), failure:@escaping (Error)->()) {
        
        let user = User.create(into: moc, name: name, email: email, isOnwer: true)
        Auth.auth().createUser(withEmail: email, password: password) { (user_, error) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            user.uid = user_!.uid
            UserDefaults.store(object: user.uid!, forKey: .uidForSignedInUser)
            completion(user)
        }
    }
    
    public static func loginAndFetchDataFromServer(withEmail email: String, password: String, success:@escaping ()->(), failure:@escaping (Error)->()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            let uid = user!.uid
            FireDatabase.user(uid: uid).reference.observeSingleEvent(of: .value, with: <#T##(DataSnapshot) -> Void#>)
        }
    }
    
    public static func fetchSignedInUser() -> User {
        let predicate = User.predicate(format: "%K == %d", #keyPath(uid), UserDefaults.retrieveValueOrFatalError(forKey: .uidForSignedInUser))
        return User.findOrFetch(in: mainContext, matching: predicate)!
    }
    
    
    // MARK: - Fileprivate
    
    @NSManaged fileprivate var primitiveIsFavorite: Bool
    
    
    
}

extension User {
    
}


extension User: Managed {
    
}





















