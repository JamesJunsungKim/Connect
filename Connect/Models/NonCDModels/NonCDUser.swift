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

struct NonCDUser:BaseModel {
    var uid: String?
    let name: String
    var phoneNumber: String?
    let emailAddress: String
    var isFavorite = false
    var isOwner = false
    
    var contacts = [NonCDUser]()
    var profilePhoto: NonCDPhoto?
    var groups = [Group]()

}

extension NonCDUser {
    
    public struct Key {
        static let user = "NonCDUser"
    }
    
    init(name: String, email:String) {
        self.uid = nil; self.phoneNumber = nil; self.contacts = []; self.profilePhoto = nil; self.groups = []
        self.name = name; self.emailAddress = email
    }
    
    // MARK: - Static
    public static func create(name:String, email: String, password: String, completion:@escaping (NonCDUser)->(), failure:@escaping (Error)->()) {
        var user = NonCDUser(name: name, email: email)
        Auth.auth().createUser(withEmail: email, password: password) { (user_, error) in
            guard error == nil else {
                failure(error!)
                return
            }
            
            user.uid = user_!.uid
            completion(user)
        }
    }
    
    
    
    // MARK: - Fileprivate
    
    
    
    
}










