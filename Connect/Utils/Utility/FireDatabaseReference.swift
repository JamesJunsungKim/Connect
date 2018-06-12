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
    
    enum Category: String {
        case user = "User"
        case message = "Message"
    }

    enum PathKeys: String {
        case isPrivate = "private"
        case isPublic = "public"
        case sentRequests = "sentRequests"
        case receivedRequests = "receivedRequests"
        case approvedRequests = "approvedRequests"
    }
    
    case root
    case user(uid:String)
    case sentRequest(fromUid:String, toUid: String)
    case receivedRequest(fromUid:String, toUid:String)
    case receivedRequests(uid:String)
    case approvedRequests(uid:String)
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
        case .user(let uid): return userPath(uid: uid)
        case .message(let uid): return "\(Message.Keys.message)/\(uid)"
        case .sentRequest(let fromUID, let toUID):
            return createPath(forKey: .sentRequests, withUID: fromUID, toUID: toUID)
        case .receivedRequest(let fromUID, let toUID):
            return createPath(forKey: .receivedRequests, withUID: fromUID, toUID: toUID)
        case .receivedRequests(let uid):
            return createPath(forKey: .receivedRequests, withUID: uid)
        case .approvedRequests(let uid):
            return createPath(forKey: .approvedRequests, withUID: uid)
        default: return ""
        }
    }
    
    fileprivate var rootReference: DatabaseReference {
        return Database.database().reference()
    }
    fileprivate func userPath(uid:String)-> String {
        return "\(User.Key.user)/\(uid)"
    }
    
    fileprivate func createPath(forKey key: PathKeys, withUID uid: String, toUID: String? = nil) -> String {
        let path = userPath(uid: uid) + "/\(key.rawValue)"
        return toUID != nil ? path + "/\(toUID!)" : path
    }
}

enum UserCase {
    case profile
    
    fileprivate var path: String {
        return ""
    }
}

















