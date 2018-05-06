//
//  Photo.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData

final class Photo: NSManagedObject {
    @NSManaged fileprivate(set) var id: UUID
    @NSManaged fileprivate(set) var imageData: Data
    @NSManaged fileprivate(set) var width: Double
    @NSManaged fileprivate(set) var height: Double
    @NSManaged fileprivate(set) var isDownloaded: Bool
    @NSManaged fileprivate(set) var url : URL
    
    @NSManaged fileprivate(set) var profileUser: User?
    @NSManaged fileprivate(set) var fromMessage: Message?
    
    public var ratio: Double {
        return width/height
    }
    
    
}
