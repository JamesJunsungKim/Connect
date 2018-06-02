//
//  ConnectTests.swift
//  ConnectTests
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import XCTest
import CoreData
@testable import Connect

class ConnectTests: XCTestCase {
    
    fileprivate var managedObjectContext: NSManagedObjectContext!
    fileprivate var appStatus: AppStatus!
    
    struct Checkup {
        static let name = "Random James1"
        static let status = "Random Status"
        static let phoneNumber = "12345"
        static let isPrivate = true
    }
    
    override func setUp() {
        super.setUp()
        managedObjectContext = NSManagedObjectContext.connectInMemryTestContext()
        let user = User.create(into: managedObjectContext, uid: nil, name: "Test", email: "Test@gmail.com")
        user.assign(uid: UUID().uuidString)
        appStatus = AppStatus(currentUser: user, mainContext: managedObjectContext)
    }
    
    override func tearDown() {
        managedObjectContext = nil
        super.tearDown()
    }
    
    // MARK: - Setting
    func editSettingViewController() {
        let user = appStatus.user
        let attributes = User.settingAttributes()
        
        // Name
        var nameAttribute = attributes.first(where: {$0.contentType == .name})!
        nameAttribute.content = Checkup.name
        
        appStatus.updateSettingAttributeAndPatch(withAttribute: nameAttribute, success: {
            XCTAssertEqual(user.name, Checkup.name)
        }) { (_) in
            XCTFail()
        }
        
        // Status Message
        var statusAttribute = attributes.first(where: {$0.contentType == .status})!
        statusAttribute.content = Checkup.status
        
        appStatus.updateSettingAttributeAndPatch(withAttribute: statusAttribute, success: {
            XCTAssertEqual(user.statusMessage, Checkup.status)
        }) { (_) in
            XCTFail()
        }
        
        // Phone Number
        
        var numberAttribute = attributes.first(where: {$0.contentType == .phoneNumber})!
        numberAttribute.content = Checkup.phoneNumber
        
        appStatus.updateSettingAttributeAndPatch(withAttribute: numberAttribute, success: {
            XCTAssertEqual(user.phoneNumber, Checkup.phoneNumber)
        }) { (_) in
            XCTFail()
        }
        
        // Privat account
        let previousValueForPrivae = user.isPrivate
        user.privateSwitchToggled(success: {
            XCTAssertEqual(user.isPrivate, !previousValueForPrivae)
        }) { (_) in
            XCTFail()
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
}
