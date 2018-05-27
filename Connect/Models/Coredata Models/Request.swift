//
//  Request.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import CoreData
import SwiftyJSON
import FirebaseDatabase

enum Urgency: Int {
    case normal, urgent, emergency
}

enum RequestType: Int {
    case friendRequest
}

final class Request: NSManagedObject, BaseModel{
    
    @NSManaged fileprivate(set) var uid: String
    @NSManaged fileprivate(set) var fromUID: String
    @NSManaged fileprivate(set) var toUID: String
    @NSManaged fileprivate(set) var urgencyNumberValue: Int16
    @NSManaged fileprivate(set) var requestTypeNumberValue: Int16
    @NSManaged fileprivate(set) var createdAt: Date
    @NSManaged fileprivate(set) var isCompleted: Bool
    @NSManaged fileprivate(set) var completedAt: Date?
    
    @NSManaged fileprivate(set) var toUser: User?
    @NSManaged fileprivate(set) var fromUser: User?
    
    public var urgency: Urgency {
        guard let r = Urgency(rawValue: Int(urgencyNumberValue)) else {
            fatalError("severity number goes out of the scope")
        }
        return r
    }
    
    public var requestType: RequestType {
        guard let t = RequestType(rawValue: Int(requestTypeNumberValue)) else {fatalError()}
        return t
    }
    
    
    struct Key {
        static let uid = "uid"
        static let request = "Request"
        static let fromUID = "fromUID"
        static let toUID = "toUID"
        static let urgencyNumberValue = "severityNumberValue"
        static let requestTypeNumberValue = "requestTypeNumberValue"
        static let createdAt = "createdAt"
        static let isCompleted = "isCompleted"
        static let toUser = "toUser"
        static let fromUser = "fromUser"
        
        
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
    public func uploadToServer(success:@escaping successWithoutModel, failure: @escaping failure) {
        let group = DispatchGroup()
        
        let references : [DatabaseReference] = [
        FireDatabase.user(uid: fromUID).reference.child(User.Key.sentRequests).child(toUID),
        FireDatabase.user(uid: toUID).reference.child(User.Key.receivedRequests).child(fromUID)
        ]
        
        references.forEach({
            group.enter()
            $0.setValue(toDictionary(), withCompletionBlock: { (error, _) in
            group.leave()
                guard error == nil else {
                    failure(error!)
                    return
                }
        })})
        group.notify(queue: DispatchQueue.main, execute: success)
    }
    
    
    
    
    public func toDictionary() -> [String:Any] {
        return [
            Key.uid : uid,
            Key.toUID: toUID,
            Key.fromUID: fromUID,
            Key.createdAt: createdAt,
            Key.isCompleted: isCompleted,
            Key.urgencyNumberValue: urgencyNumberValue,
            Key.requestTypeNumberValue: requestTypeNumberValue
        ]
    }
    
    // MARK: - Static
    public static func create(into moc: NSManagedObjectContext = mainContext, uid: String = UUID().uuidString, creationDate: Date = Date(), isCompleted:Bool = false, fromUser: User?, toUser: User?, urgency: Urgency, requestType: RequestType) -> Request {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Request.uid), uid)
        return Request.findOrCreate(in: moc, matching: predicate, configure: { (request) in
            request.uid = uid
            request.createdAt = creationDate
            request.fromUser = fromUser
            request.toUser = toUser
            request.isCompleted = isCompleted
            request.fromUID = fromUser!.uid!
            request.toUID = toUser!.uid!
            request.urgencyNumberValue = Int16(urgency.rawValue)
            request.requestTypeNumberValue = Int16(requestType.rawValue)
        })
    }
    
    public static func convertAndCreate(fromJSON json: JSON, into moc: NSManagedObjectContext) -> Request {
        let uid = json[Key.uid].stringValue
        let createdAt = Date.withISODateString(json[Key.createdAt].stringValue)
        let fromUID = json[Key.fromUID].stringValue
        let toUID = json[Key.toUID].stringValue
        let isCompleted = json[Key.isCompleted].boolValue
        let urgencyNumber = json[Key.urgencyNumberValue].intValue
        let requestNumber = json[Key.requestTypeNumberValue].intValue
        let requestType = RequestType.init(rawValue: requestNumber)!
        
        assert(toUID == AppStatus.current.user.uid!, "It must be a request toward the current user")
        
        let request = Request.create(into: moc, uid: uid, creationDate: createdAt, isCompleted: isCompleted, fromUser: requestType != .friendRequest ? User.findOrFetch(forUID: fromUID)! : nil, toUser: AppStatus.current.user, urgency: Urgency.init(rawValue: urgencyNumber)!, requestType: requestType)
        return request
    }
    
    public static func findOrFetch(forUID uid: String, fromMOC moc: NSManagedObjectContext = mainContext) -> Request? {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Request.uid), uid)
        return Request.findOrFetch(in: moc, matching: predicate)
    }
    
    
    // MARK: - Fileprivate
    
    

}


extension Request: Managed{}
