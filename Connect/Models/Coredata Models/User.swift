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
import FirebaseAuth
import FirebaseDatabase

final class User: NSManagedObject, BaseModel {
    
    @NSManaged fileprivate(set) var uid: String?
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var emailAddress: String
    @NSManaged fileprivate(set) var phoneNumber: String?
    @NSManaged fileprivate(set) var statusMessage: String?
    @NSManaged fileprivate(set) var isFavorite: Bool
    @NSManaged fileprivate(set) var isOwner: Bool
    
    @NSManaged fileprivate(set) var contacts: Set<User>?
    @NSManaged fileprivate(set) var profilePhoto: Photo?
    @NSManaged fileprivate(set) var groups: Set<Group>?
    
    struct Key {
        static let user = "User"
        static let uid = "uid"; static let name = "name"
        static let phoneNumber = "phoneNumber"
        static let statusMessage = "statusMessage"
        static let email = "emailAddress"
        static let isFavorite = "isFavorite"
        static let isOwner = "isOwner"
        static let contacts = "contacts"
        static let profilePhoto = "profilePhoto"
        static let groups = "groups"
    }
    
    override func awakeFromInsert() {
        primitiveIsFavorite = false
    }
    
    // MARK: - Public
    
    public func uploadToServer(success:@escaping ()->(), failure:@escaping (Error)->()) {
        let ref = FireDatabase.user(uid: uid!).reference
        ref.setValue(toDictionary()) { (error, _) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            success()
        }
    }
    
    public func signOut(success:()->(), failure: @escaping (Error)->()) {
        do {
            try Auth.auth().signOut()
            UserDefaults.removeValue(forKey: .uidForSignedInUser)
            success()
        } catch let error{
            logError(error.localizedDescription)
            failure(error)
        }
    }
    
    public func setProfilePhoto(with photo: Photo) {
        profilePhoto = photo
    }
    
    public func toDictionary() -> [String:Any] {
         let dict:[String:Any] = [
            Key.uid : uid!,
            Key.name: name,
            Key.email: emailAddress,
            Key.phoneNumber: phoneNumber.unwrapOrNull(),
            Key.statusMessage: statusMessage.unwrapOrNull(),
            Key.isFavorite: isFavorite,
            Key.isOwner: isOwner,
            Key.profilePhoto: profilePhoto!.toDictionary()
        ]
        return dict
    }
    
    // MARK: - Static
    public static func create(into moc: NSManagedObjectContext,uid: String?, name: String, email: String, isOnwer: Bool = false, isFavorite:Bool = false)->User {
        let user: User = moc.insertObject()
        user.uid = uid
        user.name = name
        user.emailAddress = email
        user.isOwner = isOnwer
        user.isFavorite = isFavorite
        user.phoneNumber = nil
        user.statusMessage = nil
        return user
    }
    
    public static func createAndRegister(into moc: NSManagedObjectContext, name:String, email: String, password: String, completion:@escaping (User)->(), failure:@escaping (Error)->()) {
        
        let user = User.create(into: moc, uid: nil, name: name, email: email, isOnwer: true)
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
    
    public static func loginAndFetchAndCreate(into moc: NSManagedObjectContext,withEmail email: String, password: String, success:@escaping (User)->(), failure:@escaping (Error)->()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            let uid = user!.uid
            FireDatabase.user(uid: uid).reference.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let json = snapshot.value as? JSON else {fatalError("wrong data")}
                User.convertAndCreate(fromJSON: json, into: moc, completion: { (user) in
                    UserDefaults.store(object: user.uid!, forKey: .uidForSignedInUser)
                    success(user)
                })
            })
        }
    }
    
    public static func fetchSignedInUser() -> User {
        let uid = UserDefaults.retrieveValueOrFatalError(forKey: .uidForSignedInUser) as! String
        let predicate = NSPredicate(format: "%K == %@", #keyPath(User.uid), uid)
        return User.findOrFetch(in: mainContext, matching: predicate)!
    }
    
    public static func convertAndCreate(fromJSON json: JSON,into moc: NSManagedObjectContext, completion: @escaping (User)->()) {
        
        let uid = json[Key.uid].stringValue
        let name = json[Key.name].stringValue
        let email = json[Key.email].stringValue
        let isFavorite = json[Key.isFavorite].boolValue
        let isOwner = json[Key.isOwner].boolValue
        
        let user = User.create(into: moc, uid: uid, name: name, email: email, isOnwer: isOwner, isFavorite: isFavorite)
        
        if let status = json[Key.statusMessage].string {
            user.statusMessage = status
        }
        
        if let phone = json[Key.phoneNumber].string {
            user.phoneNumber = phone
        }
        
        // need to add contacts, profile photo, and group.
        if let profileJSON = json[Key.profilePhoto] as? JSON{
            Photo.convertAndCreate(fromJSON: profileJSON, into: moc, withType: .fullResolution) { (photo) in
                user.profilePhoto = photo
                completion(user)
            }
        }
    }
    
    
    // MARK: - Fileprivate
    
    @NSManaged fileprivate var primitiveIsFavorite: Bool
    
    
    
}

extension User {
    
}


extension User: Managed {
    
}





















