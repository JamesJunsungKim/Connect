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
    fileprivate var currentUser: User!
    
    struct Checkup {
        static let name = "Random James1"
        static let status = "Random Status"
        static let phoneNumber = "12345"
        static let isPrivate = true
    }
    
    override func setUp() {
        super.setUp()
        managedObjectContext = NSManagedObjectContext.connectInMemryTestContext()
        currentUser = User.create(into: managedObjectContext, uid: nil, name: "Test", email: "Test@gmail.com")
        currentUser.assign(uid: UUID.create())
        appStatus = AppStatus(currentUser: currentUser, mainContext: managedObjectContext)
    }
    
    override func tearDown() {
        managedObjectContext = nil
        super.tearDown()
    }
    
    // MARK: - Contacts
    
    func testAddContactViewController() {
        //check if it sends a friend request to right person.
        let photo = NonCDPhoto(uid: UUID.create(), url: "https://console.firebase.google.com/u/0/project/connect-ae5e3/overview", width: nil, height: nil, isDownloaded: false)
        let searchedPerson = NonCDUser(uid: UUID.create(), name: "Search Person", phoneNumber: nil, emailAddress: "Search@gmail.com", isPrivate: false, isFavorite: false, isOwner: false, isSelected: false, contacts: [], profilePhoto: photo, groups: [])
        
        let toUser = searchedPerson.convertAndCreateUser(in: managedObjectContext)
        let request = Request.create(into: managedObjectContext, fromUser: currentUser, toUser: toUser, urgency: .normal, requestType: .friendRequest)
        let uid = request.toDictionary()[Request.Key.toUID] as! String
        let targetDict = toUser.toDictionary()
        XCTAssertEqual(uid, targetDict[User.Key.uid] as! String)
    }
    
    // MARK: - Notification
    
    func testNotificationViewController() {
        XCTAssert(true)
    }
    
    // MARK: - Setting
    func testEditSettingViewController() {
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
