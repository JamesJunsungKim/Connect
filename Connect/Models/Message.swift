//
//  Message.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData

final class Message: NSManagedObject {
    @NSManaged fileprivate(set) var id: UUID
    @NSManaged fileprivate(set) var text: String
    @NSManaged fileprivate(set) var timeStamp: Date
    
    @NSManaged fileprivate(set) var toUser: User
    @NSManaged fileprivate(set) var fromUser: User
}

extension Message:Managed {
    
}
