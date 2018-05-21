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
        enterReferenceDictionary(forType: self.classForCoder, withUID: uid)
    }
    
    override func awakeFromFetch() {
        enterReferenceDictionary(forType: self.classForCoder, withUID: uid)
    }
    
    deinit {
        leaveReferenceDictionary(forType: self.classForCoder)
    }
    
    // MARK: - Public
    
    public func toDictionary() -> [String:Any] {
        let dict: [String:Any] = [
            Key.uid : uid,
            Key.url : url!
        ]
        return dict
    }
    
    public var image: UIImage {
        return UIImage(data: imageData)!
    }
    
    // MARK: - Static
    public static func create(into moc: NSManagedObjectContext, image: UIImage, withType key:UIImage.ResolutionKey) -> Photo {
        let photo: Photo = moc.insertObject()
        photo.uid = UUID().uuidString
        photo.isDownloaded = true
        photo.imageData = image.jpegData(forKey: key)
        photo.width = Double(image.size.width)
        photo.height = Double(image.size.height)
        return photo
    }
    
    public static func createAndUpload(into moc: NSManagedObjectContext, toReference reference: StorageReference, withImage image: UIImage, withType key: UIImage.ResolutionKey, success:@escaping (Photo)->(), failure:@escaping (Error)->())  {
        let photo = Photo.create(into: moc, image: image, withType: key)
        upload(data: photo.imageData, toStorage: reference, success: { (url) in
            photo.url = url
            success(photo)
        }) { (error) in
            failure(error)
        }
    }
    
    public static func convertAndCreate(fromJSON json: JSON, into moc: NSManagedObjectContext, withType key: UIImage.ResolutionKey, completion: @escaping (Photo)->(), failure: @escaping (Error)->()) {
        let uid = json[Key.uid].stringValue
        let urlString = json[Key.url].stringValue
        
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: urlString.convertedToURL(), options: SDWebImageDownloaderOptions.highPriority, progress: nil, completed: { (image, _, error, _) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            let photo = Photo.create(into: moc, image: image!, withType: key)
            photo.uid = uid
            completion(photo)
        })
        
        
    }
    
    

    
    
    
    
    
    
    // MARK: - Filepriavte
    
}




extension Photo: Managed {}







