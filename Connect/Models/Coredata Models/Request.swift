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
    case emergency, urgent, normal
}

final class Request: NSManagedObject {
    @NSManaged fileprivate(set) var severityNumberValue: Int16
    @NSManaged fileprivate(set) var createdAt: Date
    @NSManaged fileprivate(set) var isCompleted: Bool
    @NSManaged fileprivate(set) var completedAt: Date?
    
    @NSManaged fileprivate(set) var toUser: User
    @NSManaged fileprivate(set) var fromUser: User
    
    public var severity: Severity {
        guard let r = Severity(rawValue: Int(severityNumberValue)) else {
            fatalError("severity number goes out of the scope")
        }
        return r
    }
    
    override func awakeFromInsert() {
        
    }
    
    override func awakeFromFetch() {
        
    }
    
    deinit {
        leaveReferenceDictionary(forType: self.classForCoder)
    }

}
