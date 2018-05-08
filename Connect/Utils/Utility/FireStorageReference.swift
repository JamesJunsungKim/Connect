//
//  FireStorageReference.swift
//  Connect
//
//  Created by James Kim on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import FirebaseStorage

enum FireStorage {
    case root
    case photo
    
    var reference: StorageReference {
        switch self {
        case .root: return base
        default: return base.child(path)
        }
    }
    
    fileprivate var base: StorageReference {
        return Storage.storage().reference()
    }
    
    fileprivate var path: String {
        switch self {
        case .photo: return ""
        default: return ""
        }
    }
}
