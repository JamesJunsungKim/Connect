//
//  Message.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

final class Message: CDBaseModel {
    @NSManaged fileprivate(set) var uid: String
    @NSManaged fileprivate(set) var text: String?
    @NSManaged fileprivate(set) var sentAt: Date
    
    @NSManaged fileprivate(set) var toUser: User
    @NSManaged fileprivate(set) var fromUser: User
    @NSManaged fileprivate(set) var photo: Photo?
    
    struct Keys {
        static let message = "Message"
        static let uid = "uid"
        static let text = "text"
        static let sentAt = "sentAt"
        static let toUser = "toUser"
        static let fromUser = "fromUser"
        static let photo = "photo"
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
    
    public var sectionTitle: String {
        return dateSection()
    }
    
    public var isSentByCurrentUser: Bool {
        let uid = (UserDefaults.retrieveValueOrFatalError(forKey: .uidForSignedInUser) as! String)
        return fromUser.uid! == uid
    }
    
    public var isImageMessage: Bool {
        return photo != nil
    }
   
    public func estimatedSizeForText(targetWidth: CGFloat)-> CGSize {
        if isImageMessage {
            let targetHeight = targetWidth / photo!.ratio
            return CGSize(width: targetWidth, height: targetHeight)
        } else {
            // text message
            let rect = UITextView.estimateFrameForText(cellWidth: targetWidth, forText: text!)
            return rect.size.extend(widthBy: 10, heightBy: 15)
        }
    }
    
    // MARK: - Static
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: Keys.sentAt, ascending: true)]
    }
    
    public static func create(moc: NSManagedObjectContext, fromUser: User, toUser:User, text:String?, image: UIImage?) -> Message {
        let message: Message = moc.insertObject()
        message.uid = UUID().uuidString
        message.fromUser = fromUser
        message.toUser = toUser
        message.sentAt = Date()
        message.text = text
        
        if image != nil {
            let photo = Photo.create(into: moc, image: image!, withType: .defaultResolution)
            message.photo = photo
        }
        
        return message
    }
    
    
    // MARK: - Fileprivate
    
    fileprivate func dateSection() -> String {
        return self.sentAt.format(with: "EEEE - MMM d, yyyy")
    }

}





