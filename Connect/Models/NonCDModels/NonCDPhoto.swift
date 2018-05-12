//
//  NonCDPhoto.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import Firebase

struct NonCDPhoto: SavableModel {
    static var storageRefernece: StorageReference {
        return FireStorage.profilePhoto.reference
    }
    
    static var dbReference: DatabaseReference {
        return FireDatabase.root.reference
    }
    
    let uid: String
    
    let width: Double
    let height: Double
    let url: URL
    var isDownloaded = false
}
