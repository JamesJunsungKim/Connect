//
//  NonCDUser.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import Foundation
import CoreData
import SwiftyJSON
import Firebase

struct NonCDUser:Equatable {
    var uid: String
    let name: String
    var phoneNumber: String?
    let emailAddress: String
    var isPrivate: Bool
    var isFavorite = false
    var isOwner = false
    
    var isSelected = false
    
    var contacts = [NonCDUser]()
    var profilePhoto: NonCDPhoto?
    var groups = [Group]()

}

extension NonCDUser {
    
    public struct Key {
        static let user = "NonCDUser"
    }
    
    init(json: JSON) {
        let name = json[User.Key.name].stringValue
        let email = json[User.Key.email].stringValue
        let uid = json[User.Key.uid].stringValue
        let isPrivate = json[User.Key.isPrivate].boolValue
        
        self.name = name
        self.emailAddress = email
        self.uid = uid
        self.isPrivate = isPrivate
        
        if let phone = json[User.Key.phoneNumber].string {
            self.phoneNumber = phone
        }
        
        let profileJSON = json[User.Key.profilePhoto]
        let photo = NonCDPhoto(json: profileJSON)
        
        self.profilePhoto = photo
    }
    
    // MARK: - Public
    
    public func convertAndCreateUser(in moc: NSManagedObjectContext) -> User {
        return User.create(into: moc, uid: uid, name: name, email: emailAddress, isFavorite: isFavorite, isPrivate: isPrivate)
    }
    
    public func toDictionary()->[String:Any] {
        return [
            User.Key.uid: uid,
            User.Key.name: name,
            User.Key.email: emailAddress,
            User.Key.phoneNumber: phoneNumber.unwrapOrNull(),
            User.Key.isFavorite: isFavorite,
            User.Key.isPrivate: isPrivate,
            User.Key.isPrivateAndName: "\(isPrivate)\(name)"
        ]
    }
    
    // MARK: - Static
    static func == (lhs: NonCDUser, rhs: NonCDUser) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    
    // MARK: - Fileprivate
    
    
    
    
}










