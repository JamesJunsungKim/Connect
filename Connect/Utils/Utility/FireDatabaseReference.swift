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
    
    struct PathKeys {
        static let isPrivate = "private"
        static let isPublic = "public"
    }
    
    case root
    case user(uid:String, isPrivate: Bool)
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
        case .user(let uid, let bool):
            return bool ? "\(User.Key.user)/\(PathKeys.isPrivate)/\(uid)/" : "\(User.Key.user)/\(PathKeys.isPublic)/\(uid)/"
        case .message(let uid): return "\(Message.Keys.message)/\(uid)"
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

















