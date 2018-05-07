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

fileprivate struct Key {
    static let id = "id"
    static let text = "text"
    static let timeStamp = "timeStamp"
    static let toUser = "toUser"
    static let fromUser = "fromUser"
    static let photo = "photo"
}

final class Message: NSManagedObject {
    @NSManaged fileprivate(set) var id: String
    @NSManaged fileprivate(set) var text: String?
    @NSManaged fileprivate(set) var timeStamp: Date
    
    @NSManaged fileprivate(set) var toUser: User
    @NSManaged fileprivate(set) var fromUser: User
    @NSManaged fileprivate(set) var photo: Photo?
    
    
    public var sectionTitle: String {
        return dateSection()
    }
    
    //1) send message without photo
    public static func insert(into moc: NSManagedObjectContext, text:String)->Message {
        let message = createBaseMessage(moc: moc)
        message.text = text
        return message
    }
    
    //2) send message with photo
    public static func insert(into moc: NSManagedObjectContext, image: UIImage) -> Message {
        let message = createBaseMessage(moc: moc)
        let photo = Photo.insert(into: moc, image: image)
        message.photo = photo
        return message
    }
    
    
    
    // MARK: - Fileprivate
    fileprivate static func createBaseMessage(moc: NSManagedObjectContext) -> Message {
        let message: Message = moc.insertObject()
        message.id = UUID().uuidString
        message.timeStamp = Date()
        return message
    }
    
    fileprivate func dateSection() -> String {
        return self.timeStamp.format(with: "EEEE - MMM d, yyyy")
    }

}

extension Message:Managed {
    static var defaultSortDescriptors: [NSSortDescriptor]  {
        return [NSSortDescriptor(key: Key.timeStamp, ascending: true)]
    }
}














