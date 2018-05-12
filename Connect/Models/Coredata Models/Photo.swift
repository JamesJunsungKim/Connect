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
    @NSManaged fileprivate(set) var uid: String
    @NSManaged fileprivate(set) var imageData: Data
    @NSManaged fileprivate(set) var width: Double
    @NSManaged fileprivate(set) var height: Double
    @NSManaged fileprivate(set) var isDownloaded: Bool
    @NSManaged fileprivate(set) var url : URL
    
    public var ratio: Double {
        return width/height
    }
    
    override func awakeFromInsert() {
        
    }
    
    public static func insert(into moc: NSManagedObjectContext, image: UIImage) -> Photo {
        let photo: Photo = moc.insertObject()
        photo.uid = UUID().uuidString
        photo.isDownloaded = false
        photo.imageData = image.jpegData
        photo.width = Double(image.size.width)
        photo.height = Double(image.size.height)
        return photo
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - Filepriavte
    
}




extension Photo: Managed {}







