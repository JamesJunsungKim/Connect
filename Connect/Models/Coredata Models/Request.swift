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

final class Request: CDBaseModel{
    
    @NSManaged fileprivate(set) var uid: String
    @NSManaged fileprivate(set) var fromUID: String
    @NSManaged fileprivate(set) var toUID: String
    @NSManaged fileprivate(set) var urgencyNumberValue: Int16
    @NSManaged fileprivate(set) var requestTypeNumberValue: Int16
    @NSManaged fileprivate(set) var createdAt: Date
    @NSManaged fileprivate(set) var isCompleted: Bool
    @NSManaged fileprivate(set) var completedAt: Date?
    @NSManaged fileprivate(set) var needsToDisplay: Bool
    
    @NSManaged fileprivate(set) var toUser: User
    @NSManaged fileprivate(set) var fromUser: User
    
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
    
    @objc public var sectionTitle: String {
        return createdAt.toYearToDateStringUTC()
    }
    
    public static var defaultPredicate: NSPredicate {
        return NSPredicate(format: "%K == %@", #keyPath(Request.needsToDisplay), NSNumber(value: true))
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: Key.createdAt, ascending: false)]
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
        static let completedAt = "completedAt"
        static let needsToDisplay = "needsToDisplay"
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
    public func uploadToNodeOfSentRequestsAndReceivedRequests(success:@escaping successWithoutModel, failure: @escaping failure) {
        let group = DispatchGroup()
        
        let references : [DatabaseReference] = [
            FireDatabase.user(uid: fromUID).reference.child(FireDatabase.PathKeys.sentRequests.rawValue).child(toUID),
            FireDatabase.user(uid: toUID).reference.child(FireDatabase.PathKeys.receivedRequests.rawValue).child(fromUID)
        ]
        
        references.forEach({
            group.enter()
            $0.setValue(self.toDictionary(), withCompletionBlock: { (error, _) in
                group.leave()
                guard error == nil else {failure(error!); return}
            })})
        group.notify(queue: DispatchQueue.main, execute: success)
    }
    
    public func completedByToUser(success:@escaping successWithoutModel, failure:@escaping failure) {
        isCompleted = true
        completedAt = Date()
        uploadToNodeOfApprovedRequests(success: success, failure: failure)
    }
    
    public func completedByFromUser(updatedTo appstatus: AppStatus) {
        switch requestType {
        case .friendRequest :
            appstatus.user.addUserToContact(user: toUser)
        }
        
    }
    
    public func toDictionary() -> [String:Any] {
        return [
            Key.uid : uid,
            Key.toUID: toUID,
            Key.fromUID: fromUID,
            Key.createdAt: createdAt.toYearToMillisecondStringUTC(),
            Key.isCompleted: isCompleted,
            Key.urgencyNumberValue: urgencyNumberValue,
            Key.requestTypeNumberValue: requestTypeNumberValue,
            Key.needsToDisplay : needsToDisplay
        ].addValueIfNotEmpty(forKey: Key.completedAt, value: completedAt,
                             configuration: {$0.toYearToMillisecondStringUTC()})
    }
    
    // MARK: - Static
    public static func create(into moc: NSManagedObjectContext, uid: String = UUID().uuidString, creationDate: Date = Date(), isCompleted:Bool = false, fromUser: User, toUser: User, urgency: Urgency, requestType: RequestType, needsToDisplay :Bool = true) -> Request {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Request.uid), uid)
        return Request.findOrCreate(in: moc, matching: predicate, configure: { (request) in
            request.uid = uid
            request.createdAt = creationDate
            request.fromUser = fromUser
            request.toUser = toUser
            request.isCompleted = isCompleted
            request.fromUID = fromUser.uid!
            request.toUID = toUser.uid!
            request.urgencyNumberValue = Int16(urgency.rawValue)
            request.requestTypeNumberValue = Int16(requestType.rawValue)
            request.needsToDisplay = needsToDisplay
        })
    }
    
    public static func convertAndCreate(fromJSON json: JSON, into moc: NSManagedObjectContext, success:@escaping success, failure: @escaping failure) {
        let uid = json[Key.uid].stringValue
        let createdAt = Date.ConvertToString(json[Key.createdAt].stringValue)
        let fromUID = json[Key.fromUID].stringValue
        let toUID = json[Key.toUID].stringValue
        let isCompleted = json[Key.isCompleted].boolValue
        let urgencyNumber = json[Key.urgencyNumberValue].intValue
        let requestNumber = json[Key.requestTypeNumberValue].intValue
        let requestType = RequestType.init(rawValue: requestNumber)!
        let needsToDisplay = json[Key.needsToDisplay].boolValue
        let currentUser = User.findOrFetch(forUID: toUID, fromMOC: moc)
        
        switch requestType {
        case .friendRequest:
            // we need to create an user who sent this request and save it.
            // and then make a connection btw the current user and the recently-created user.
            //assert(User.findOrFetch(forUID: fromUID) == nil)
            User.fetchUserFromServerAndCreate(withUID: fromUID, intoMOC: moc, needContactAndGroupNode: false, success: { (fromUser) in
                let request = Request.create(into: moc, uid: uid, creationDate: createdAt, isCompleted: isCompleted, fromUser: fromUser, toUser: currentUser!, urgency: Urgency.init(rawValue: urgencyNumber)!, requestType: requestType, needsToDisplay: needsToDisplay)
                    success(request)
            }, failure: { (error) in
                logError(error.localizedDescription)
                failure(error)
            })
        }
    }
    
    
    // MARK: - Fileprivate
    
    fileprivate func uploadToNodeOfApprovedRequests(success:@escaping successWithoutModel, failure:@escaping failure) {
        FireDatabase.user(uid: fromUser.uid!).reference.child(FireDatabase.PathKeys.approvedRequests.rawValue)
            .setValue(toDictionary()) { (error, _) in
                guard error == nil else {
                    failure(error!)
                    return
                }
                success()
        }
    }
    

}

