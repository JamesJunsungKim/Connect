//
//  Request.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import CoreData

enum Severity: Int {
    case normal, urgent, emergency
}

final class Request: NSManagedObject {
    @NSManaged fileprivate(set) var uid: String
    @NSManaged fileprivate(set) var fromUID: String
    @NSManaged fileprivate(set) var toUID: String
    @NSManaged fileprivate(set) var severityNumberValue: Int16
    @NSManaged fileprivate(set) var createdAt: Date
    @NSManaged fileprivate(set) var isCompleted: Bool
    @NSManaged fileprivate(set) var completedAt: Date?
    
    @NSManaged fileprivate(set) var toUser: User?
    @NSManaged fileprivate(set) var fromUser: User?
    
    public var severity: Severity {
        guard let r = Severity(rawValue: Int(severityNumberValue)) else {
            fatalError("severity number goes out of the scope")
        }
        return r
    }
    
    struct Key {
        static let request = "Request"
        static let fromUID = "fromUID"
        static let toUID = "toUID"
        static let severityNumberValue = "severityNumberValue"
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
    
    public func toDictionary() -> [String:Any] {
        
        
        return [:]
    }
    
    
    
    

}


extension Request: Managed{}
