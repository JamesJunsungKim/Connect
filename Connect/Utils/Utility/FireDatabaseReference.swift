//
//  FireDatabaseReference.swift
//  Connect
//
//  Created by James Kim on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

enum FireDatabase {
    case root
    
    case user(uid:String)
    case contacts
    case photos
    case message(userUid: String)
    case notification
    case settings
    
    var reference: DatabaseReference {
        switch self {
        case .root:
            return rootReference
        default:
            return rootReference.child(path)
        }
    }
    
    fileprivate var path: String {
        switch self {
        case .user(let uid): return "users/\(uid)"
        case .message(let uid): return "messages/\(uid)"
        default: return ""
        }
    }
    
    fileprivate var rootReference: DatabaseReference {
        return Database.database().reference()
    }
}

enum UserCase {
    case profile
    
    fileprivate var path: String {
        return ""
    }
}

















