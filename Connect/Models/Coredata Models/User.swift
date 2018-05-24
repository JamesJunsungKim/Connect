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
    @NSManaged fileprivate(set) var isPrivate: Bool
    
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
        static let isPrivate = "isPrivate"
        static let isOwner = "isOwner"
        static let contacts = "contacts"
        static let profilePhoto = "profilePhoto"
        static let groups = "groups"
    }
    
    override func awakeFromInsert() {
        enterReferenceDictionary(forType: self.classForCoder, withUID: uid)
    }
    
    override func awakeFromFetch() {
        enterReferenceDictionary(forType: self.classForCoder, withUID: uid)
    }
    
    deinit {
        leaveReferenceDictionary(forType: self.classForCoder)
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
    
    public func patch(toNode node: String, withValue value :Any, success:@escaping ()->(), failure: @escaping (Error)->()) {
        let ref = FireDatabase.user(uid: uid!).reference.child(node)
        ref.setValue(value) { (error, _) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            success()
        }
    }
    
    public func unwrapStatusMessageOrDefault() -> String {
        return statusMessage.unwrapOr(defaultValue: "Your message will be displayed to your contacts.")
    }
    
    public func signOut(success:()->(), failure: @escaping (Error)->()) {
        do {
            try Auth.auth().signOut()
            success()
        } catch let error{
            logError(error.localizedDescription)
            failure(error)
        }
    }
    
    public func updateSettingAttributeAndPatch(withAttribute attribute: SettingAttribute, success:@escaping ()->(), failure:@escaping (Error)->()) {
        var path: String!
        switch attribute.contentType {
        case .name:
            name = attribute.content!
            path = Key.name
        case .status:
            statusMessage = attribute.content!
            path = Key.statusMessage
        case .phoneNumber:
            phoneNumber = attribute.content!
            path = Key.phoneNumber
        default: fatalError()
        }
        
        patch(toNode: path, withValue: attribute.content!, success: {
            success()
        }) { (error) in
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
            Key.isPrivate : isPrivate,
            Key.isFavorite: isFavorite,
            Key.isOwner: isOwner,
            Key.profilePhoto: profilePhoto!.toDictionary()
        ]
        return dict
    }
    
    public func privateSwitchToggled(success:@escaping ()->(), failure:@escaping(Error)->()) {
        isPrivate = !isPrivate
        patch(toNode: Key.isPrivate, withValue: isPrivate, success: {
            success()
        }) { (error) in
            failure(error)
        }
    }
    
    // MARK: - Static
    public static func create(into moc: NSManagedObjectContext, uid: String?, name: String, email: String, isOnwer: Bool = false, isFavorite:Bool = false, isPrivate: Bool = false)->User {
        let user: User = moc.insertObject()
        user.uid = uid
        user.name = name
        user.emailAddress = email
        user.isOwner = isOnwer
        user.isFavorite = isFavorite
        user.isPrivate = isPrivate
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
                guard let dict = snapshot.value else {fatalError()}
                let json = JSON(dict)
                User.convertAndCreate(fromJSON: json, into: moc, completion: { (user) in
                    UserDefaults.store(object: uid, forKey: .uidForSignedInUser)
                    success(user)
                }, failure: { (error) in
                    failure(error)
                })
            })
        }
    }
    
    public static func fetchSignedInUser() -> User {
        let uid = UserDefaults.retrieveValueOrFatalError(forKey: .uidForSignedInUser) as! String
        let predicate = NSPredicate(format: "%K == %@", #keyPath(User.uid), uid)
        return User.findOrFetch(in: mainContext, matching: predicate)!
    }
    
    public static func convertAndCreate(fromJSON json: JSON, into moc: NSManagedObjectContext, completion: @escaping (User)->(), failure: @escaping (Error)->()) {
        
        let uid = json[Key.uid].stringValue
        let name = json[Key.name].stringValue
        let email = json[Key.email].stringValue
        let isFavorite = json[Key.isFavorite].boolValue
        let isOwner = json[Key.isOwner].boolValue
        let isPrivate = json[Key.isPrivate].boolValue
        
        let user = User.create(into: moc, uid: uid, name: name, email: email, isOnwer: isOwner, isFavorite: isFavorite, isPrivate: isPrivate)
        
        if let status = json[Key.statusMessage].string {
            user.statusMessage = status
        }
        
        if let phone = json[Key.phoneNumber].string {
            user.phoneNumber = phone
        }
        
        // need to add contacts, profile photo, and group.
        if json[Key.profilePhoto].null == nil{
            let profileJSON = json[Key.profilePhoto]
            Photo.convertAndCreate(fromJSON: profileJSON, into: moc, withType: .fullResolution, completion: { (photo) in
                user.profilePhoto = photo
                completion(user)
            }) { (error) in
                failure(error)
            }
        }
    }
    
    public static func getList(with type: String, selectedType: String) -> [NonCDUser] {
        FireDatabase.root.reference.child("users").queryOrdered(byChild: "name").queryEqual(toValue: type).observeSingleEvent(of: .value) { (snapshot) in
            let results = snapshot.value as! [String:[String:Any]]
            print(results.values.map({NonCDUser(json: JSON($0))}))
        }
        return []
    }
    
    public static func settingAttributes() -> [SettingAttribute] {
        return [
            SettingAttribute(type: .label, title: "Name", content: "Your Name", contentType: .name, description: "Name",toggleSource: nil, maximumLimit: 20, targetIndexPath: IndexPath(row: 100, section: 0)),
            SettingAttribute(type: .label, title: "Status Message", content: "Your message will be displayed to your contacts.", contentType: .status, description: "Status Message",toggleSource: nil, maximumLimit: 20, targetIndexPath: IndexPath(row: 0, section: 0)),
            SettingAttribute(type: .label, title: "Phone Number", content: "Your phone number won't be shown to your contacts", contentType: .phoneNumber, description: "Enter your phone number", toggleSource:nil, maximumLimit: 10, targetIndexPath: IndexPath(row: 0, section: 1)),
            SettingAttribute(type: .label, title: "Email Address", content: "Email address", contentType: .email,  description: "Change your email address",toggleSource:nil, maximumLimit: 10, targetIndexPath: IndexPath(row: 1, section: 1)),
            SettingAttribute(type: .toggle, title: "Make your account private", content: nil, contentType: .isAccountPrivate, description: "Change your account to private mode", toggleSource:.isAccountPrivate, maximumLimit: nil, targetIndexPath: IndexPath(row: 0, section: 2)),
            SettingAttribute(type: .onlyAction, title: "SignOut", content: nil,  contentType: .auctionNotRequired, description: nil, toggleSource:nil, maximumLimit: nil, targetIndexPath: IndexPath(row: 0, section: 3))
        ]
    }
    
    // MARK: - Fileprivate
    
    @NSManaged fileprivate var primitiveIsFavorite: Bool
    
    
    
}

extension User {
    
}


extension User: Managed {
    
}





















