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
import FirebaseDatabase

struct NonCDUser {
    
    let id: String
    var name: String?
    var phoneNumber: String?
    let emailAddress: String
    var isFavorite = false
    var isOwner = false
    
    var contacts = [NonCDUser]()
    var profilePhoto: NonCDPhoto?
    var groups = [Group]()
}
