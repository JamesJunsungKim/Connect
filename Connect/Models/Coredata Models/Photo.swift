//
//  Photo.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase
import CoreData
import SDWebImage

final class Photo: NSManagedObject, uploadableModel {
    static var dbReference: DatabaseReference {
        return FireDatabase.contacts.reference
    }
    
    @NSManaged fileprivate(set) var uid: String
    @NSManaged fileprivate(set) var imageData: Data
    @NSManaged fileprivate(set) var width: Double
    @NSManaged fileprivate(set) var height: Double
    @NSManaged fileprivate(set) var isDownloaded: Bool
    @NSManaged fileprivate(set) var url : String?
    
    public var ratio: Double {
        return width/height
    }
    
    struct Key {
        static let photo = "Photo"; static let uid = "uid"
        static let width = "width"; static let height = "height"
        static let url = "url"
    }
    
    override func awakeFromInsert() {
        
    }
    
    // MARK: - Public
    
    public func toDictionary() -> [String:Any] {
        let dict: [String:Any] = [
            Key.uid : uid,
            Key.url : url!
        ]
        return dict
    }
    
    
    // MARK: - Static
    public static func create(into moc: NSManagedObjectContext, image: UIImage, withType key:UIImage.Key) -> Photo {
        let photo: Photo = moc.insertObject()
        photo.uid = UUID().uuidString
        photo.isDownloaded = false
        photo.imageData = image.jpegData(forKey: key)
        photo.width = Double(image.size.width)
        photo.height = Double(image.size.height)
        return photo
    }
    
    public static func createAndUpload(into moc: NSManagedObjectContext, toReference reference: StorageReference, withImage image: UIImage, withType key: UIImage.Key, success:@escaping (Photo)->(), failure:@escaping (Error)->())  {
        let photo = Photo.create(into: moc, image: image, withType: key)
        upload(data: photo.imageData, toStorage: reference, success: { (url) in
            photo.url = url
            success(photo)
        }) { (error) in
            failure(error)
        }
    }
    
    public static func convertAndCreate(fromJSON json: JSON, into moc: NSManagedObjectContext, withType key: UIImage.Key, completion: @escaping (Photo)->()) {
        let uid = json[Key.uid].stringValue
        let urlString = json[Key.url].stringValue
        
        UIImageView().sd_setImage(with: urlString.convertedToURL()) { (image, error, _, _) in
            let photo = Photo.create(into: moc, image: image!, withType: key)
            photo.uid = uid
            completion(photo)
        }
    }
    
    
    
    
    
    
    // MARK: - Filepriavte
    
}




extension Photo: Managed {}







