//
//  BaseModel.swift
//  Connect
//
//  Created by James Kim on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData
import FirebaseDatabase
import SwiftyJSON

protocol BaseModel:Unwrappable {
    typealias success = (Self)->()
    typealias successWithoutModel = ()->()
    typealias failure = (Error)->()
}
