//
//  NonCDPhoto.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase

struct NonCDPhoto: uploadableModel {
    
    static var dbReference: DatabaseReference {
        return FireDatabase.root.reference
    }
    
    let uid: String
    let url: String
    
    var width: Double?
    var height: Double?
    var isDownloaded = false
}

extension NonCDPhoto {
    
    init(json: JSON) {
        let uid = json[Photo.Key.uid].stringValue
        let url = json[Photo.Key.url].stringValue
        
        self.uid = uid
        self.url = url
    }
}
