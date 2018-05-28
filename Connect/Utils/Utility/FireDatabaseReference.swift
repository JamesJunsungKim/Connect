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
        static let sentRequests = "sentRequests"
        static let receivedRequests = "receivedRequests"
    }
    
    case root
    case user(uid:String)
    case sentRequest(fromUid:String, toUid: String)
    case receivedRequest(fromUid:String, toUid:String)
    case receivedRequests(uid:String)
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
    
    fileprivate func userPath(uid:String)-> String {
        return "\(User.Key.user)/\(uid)/"
    }
    
    fileprivate var path: String {
        switch self {
        case .user(let uid): return userPath(uid: uid)
        case .message(let uid): return "\(Message.Keys.message)/\(uid)"
        case .sentRequest(let fromUID, let toUID): return userPath(uid: fromUID) + "\(PathKeys.sentRequests)/\(toUID)"
        case .receivedRequest(let fromUID, let toUID): return userPath(uid: fromUID) + "\(PathKeys.receivedRequests)/\(toUID)"
        case .receivedRequests(let uid): return userPath(uid: uid) + "\(PathKeys.receivedRequests)"
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

















