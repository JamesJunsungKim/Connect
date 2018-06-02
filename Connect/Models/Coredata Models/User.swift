//
//  User.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
import FirebaseAuth
import FirebaseDatabase

final class User: CDBaseModel {
    
    @NSManaged fileprivate(set) var uid: String?
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var emailAddress: String
    @NSManaged fileprivate(set) var phoneNumber: String?
    @NSManaged fileprivate(set) var statusMessage: String?
    @NSManaged fileprivate(set) var isFavorite: Bool
    @NSManaged fileprivate(set) var isPrivate: Bool
    
    @NSManaged fileprivate(set) var contacts: Set<User>?
    @NSManaged fileprivate(set) var profilePhoto: Photo?
    @NSManaged fileprivate(set) var groups: Set<Group>?
    
    @NSManaged fileprivate(set) var sentRequests: Set<Request>?
    @NSManaged fileprivate(set) var receivedRequests: Set<Request>?
    
    public var isSelected = false
    
    struct Key {
        static let user = "User"
        static let uid = "uid"; static let name = "name"
        static let phoneNumber = "phoneNumber"
        static let statusMessage = "statusMessage"
        static let email = "emailAddress"
        static let isFavorite = "isFavorite"
        static let isPrivate = "isPrivate"
        static let contacts = "contacts"
        static let profilePhoto = "profilePhoto"
        static let groups = "groups"
        
        static let isPrivateAndName = "isPrivateAndName"
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
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
    
    // MARK: - Public
    
    public func assign(uid:String?) {
        self.uid = uid
    }
    
    public func uploadToServer(success:@escaping ()->(), failure:@escaping (Error)->()) {
        let ref = FireDatabase.user(uid: uid!).reference
        ref.setValue(toDictionary(needToIncludeContactAndRequest: true)) { (error, _) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            success()
        }
    }
    
    public func patch(toNode node: String, withValue value :Any, success:@escaping ()->(), failure: @escaping (Error)->()) {
        let ref = FireDatabase.user(uid: uid!).reference.child(node)
        
        ref.setValue(value) { (error, _) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            success()
        }
    }
    
    public func removeFromCurrentNode() {
        FireDatabase.user(uid: uid!).reference.removeValue()
    }
    
    public func unwrapStatusMessageOrDefault() -> String {
        return statusMessage.unwrapOr(defaultValue: "Your message will be displayed to your contacts.")
    }
    
    public func signOut(success:successWithoutModel, failure: @escaping failure) {
        do {
            try Auth.auth().signOut()
            success()
        } catch let error{
            logError(error.localizedDescription)
            failure(error)
        }
    }
    
    public func updateSettingAttributeAndPatch(withAttribute attribute: SettingAttribute, success:@escaping successWithoutModel, failure:@escaping failure) {
        var dict = [String:String]()
        switch attribute.contentType {
        case .name:
            name = attribute.content!
            dict[Key.name] = name
            dict[Key.isPrivateAndName] = getValueForPrivateAndName()
        case .status:
            statusMessage = attribute.content!
            dict[Key.statusMessage] = statusMessage
        case .phoneNumber:
            phoneNumber = attribute.content!
            dict[Key.phoneNumber] = phoneNumber
        default: fatalError()
        }
        
        guard !isTesting else {success();return}
        dict.asyncForEach(completion: success) {[unowned self] (arg, innerCompletion) in
            let (key, value) = arg
            self.patch(toNode: key, withValue: value, success: innerCompletion, failure: { (error) in
                failure(error)
            })
        }
    }
    
    public func addUserToContact(user: User) {
        let result = contacts?.insert(user)
        // TODO: Need to enable it
        print("the insert result: " + String(describing: result?.inserted))
//        guard result!.inserted else {assertionFailure(); return}
    }
    
    public func setProfilePhoto(with photo: Photo) {
        profilePhoto = photo
    }
    
    public func toDictionary(needToIncludeContactAndRequest flag: Bool = false) -> [String:Any] {
        
         let dict:[String:Any] = [
            Key.uid : uid!,
            Key.name: name,
            Key.email: emailAddress,
            Key.phoneNumber: phoneNumber.unwrapOrNull(),
            Key.statusMessage: statusMessage.unwrapOrNull(),
            Key.isPrivate : isPrivate,
            Key.isFavorite: isFavorite,
            Key.profilePhoto: profilePhoto!.toDictionary(),
            Key.isPrivateAndName: getValueForPrivateAndName(),
        ]
        
        if flag {
            return dict
                .addValueIfNotEmpty(forKey: Key.contacts, value: contacts){ (users) -> [String:[String:Any]] in
                    var dict_ = [String:[String:Any]]()
                    users.forEach({dict_[$0.uid!] = $0.toDictionary()})
                    return dict_
                }
                .addValueIfNotEmpty(forKey: FireDatabase.PathKeys.sentRequests.rawValue, value: sentRequests) { (requests) -> [String:[String:Any]] in
                    var dict_ = [String:[String:Any]]()
                    requests.forEach({dict_[$0.uid] = $0.toDictionary()})
                    return dict_
                }
                .addValueIfNotEmpty(forKey: FireDatabase.PathKeys.receivedRequests.rawValue, value: receivedRequests) { (requests) -> [String:[String:Any]] in
                    var dict_ = [String:[String:Any]]()
                    requests.forEach({dict_[$0.uid] = $0.toDictionary()})
                    return dict_
            }
            
        } else {
            return dict
        }
    }
    
    public func privateSwitchToggled(success:@escaping ()->(), failure:@escaping(Error)->()) {
        isPrivate = !isPrivate
        let groupForPrivate:[String:Any] = [Key.isPrivate: isPrivate, Key.isPrivateAndName: getValueForPrivateAndName()]
        
        guard !isTesting else {success();return}
        groupForPrivate.asyncForEach(completion: success) {[unowned self] (arg0, innerCompletion) in
            let (key, value) = arg0
            self.patch(toNode: key, withValue: value, success: innerCompletion, failure: { (error) in
                failure(error)
            })
        }
    }
    
    public func insert(request:Request, intoSentNode flag: Bool) {
        if flag {
            // TODO: make sure that it is inserted only one time.
            let _ = sentRequests?.insert(request)
//            guard result!.inserted else{assertionFailure(); return}
        } else {
            let _ = receivedRequests?.insert(request)
//            guard result!.inserted else {assertionFailure(); return}
        }
    }
    
    // MARK: - Static
    public static func create(into moc: NSManagedObjectContext, uid: String?, name: String, email: String, isFavorite:Bool = false, isPrivate: Bool = false)->User {
        if uid != nil {
            let result = findOrFetch(forUID: uid!, fromMOC: moc)
            if result != nil {return result!}
        }
        
        let user: User = moc.insertObject()
        user.assign(uid: uid)
        user.name = name
        user.emailAddress = email
        user.isFavorite = isFavorite
        user.isPrivate = isPrivate
        user.phoneNumber = nil
        user.statusMessage = nil
        return user
    }
    
    public static func createAndRegister(into moc: NSManagedObjectContext, name:String, email: String, password: String, completion:@escaping (User)->(), failure:@escaping (Error)->()) {
        
        let user = User.create(into: moc, uid: nil, name: name, email: email)
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            user.assign(uid: result!.user.uid)
            UserDefaults.store(object: user.uid!, forKey: .uidForSignedInUser)
            completion(user)
        }
    }
    
    public static func loginAndFetchAndCreate(into moc: NSManagedObjectContext,withEmail email: String, password: String, success:@escaping (User)->(), failure:@escaping (Error?)->()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return
            }
            let uid = result!.user.uid
            fetchUserFromServerAndCreate(withUID: uid, needContactAndGroupNode: true, success: success, failure: failure)
        }
    }
    
    public static func fetchUserFromServerAndCreate(withUID uid: String, needContactAndGroupNode flag: Bool, success:@escaping success, failure:@escaping failure) {
        
        FireDatabase.user(uid: uid).reference.observeSingleEvent(of: .value) { (snapshot) in
            guard let dict = snapshot.value else{
                assertionFailure()
                return
            }
            let json = JSON(dict)
            User.convertAndCreate(fromJSON: json, into: mainContext, completion: { (user) in
                success(user)
            }, failure: { (error) in
                failure(error)
            }, needContactAndGroup: flag)
        }
    }
    
    public static func fetchSignedInUser(fromMOC moc: NSManagedObjectContext = mainContext) -> User {
        let uid = UserDefaults.retrieveValueOrFatalError(forKey: .uidForSignedInUser) as! String
        return findOrFetch(forUID: uid, fromMOC: moc)!
    }
    
    public static func convertAndCreate(fromJSON json: JSON, into moc: NSManagedObjectContext, completion: @escaping (User)->(), failure: @escaping (Error)->(), needContactAndGroup: Bool = false) {
        
        let group = DispatchGroup()
        
        let uid = json[Key.uid].stringValue
        let name = json[Key.name].stringValue
        let email = json[Key.email].stringValue
        let isFavorite = json[Key.isFavorite].boolValue
        let isPrivate = json[Key.isPrivate].boolValue
        
        let user = User.create(into: moc, uid: uid, name: name, email: email, isFavorite: isFavorite, isPrivate: isPrivate)

        if let status = json[Key.statusMessage].string {
            user.statusMessage = status
        }
        
        if let phone = json[Key.phoneNumber].string {
            user.phoneNumber = phone
        }
        
        // need to add contacts, profile photo, and group.
        if json[Key.profilePhoto].null == nil{
            group.enter()
            let profileJSON = json[Key.profilePhoto]
            Photo.convertAndCreate(fromJSON: profileJSON, into: moc, withType: .fullResolution, completion: { (photo) in
                user.profilePhoto = photo
                group.leave()
            }) { (error) in
                failure(error)
            }
        }
        
        if needContactAndGroup {
            if json[Key.contacts].null == nil {
                let dictionary = json[Key.contacts].dictionaryValue
                dictionary.values.forEach({
                    group.enter()
                    User.convertAndCreate(fromJSON: $0, into: mainContext, completion: { (contact) in
                        user.contacts?.insert(contact)
                    group.leave()
                }, failure: { (error) in
                    failure(error)
                })})
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(user)
        }
    }
    
    public static func getList(withInput input: String, selectedType: String, completion:@escaping (([NonCDUser])->())) {
        let condition = selectedType == "Name"
        FireDatabase.root.reference.child(User.Key.user).queryOrdered(byChild: condition ? User.Key.isPrivateAndName : User.Key.email).queryEqual(toValue: condition ? "false\(input)" : input)
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let results = snapshot.value as? [String:[String:Any]] else {
                    completion([NonCDUser]())
                    return
                }
                completion(results.values.map({NonCDUser(json: JSON($0))}))
        }
    }
    
    public static func settingAttributes() -> [SettingAttribute] {
        return [
            SettingAttribute(type: .label, title: "Name", content: "Your Name", contentType: .name, description: "Name",toggleSource: nil, maximumLimit: 20, targetIndexPath: IndexPath(row: 100, section: 0)),
            SettingAttribute(type: .label, title: "Status Message", content: "Your message will be displayed to your contacts.", contentType: .status, description: "Status Message",toggleSource: nil, maximumLimit: 20, targetIndexPath: IndexPath(row: 0, section: 0)),
            SettingAttribute(type: .label, title: "Phone Number", content: "Your phone number won't be shown to your contacts", contentType: .phoneNumber, description: "Enter your phone number", toggleSource:nil, maximumLimit: 10, targetIndexPath: IndexPath(row: 0, section: 1)),
            SettingAttribute(type: .label, title: "Email Address", content: "Email address", contentType: .email,  description: "Change your email address",toggleSource:nil, maximumLimit: 10, targetIndexPath: IndexPath(row: 1, section: 1)),
            SettingAttribute(type: .toggle, title: "Make your account private", content: nil, contentType: .isAccountPrivate, description: "Change your account to private mode", toggleSource: nil, maximumLimit: nil, targetIndexPath: IndexPath(row: 0, section: 2)),
            SettingAttribute(type: .onlyAction, title: "SignOut", content: nil,  contentType: .auctionNotRequired, description: nil, toggleSource:nil, maximumLimit: nil, targetIndexPath: IndexPath(row: 0, section: 3))
        ]
    }
    
    public static func predicateFor(uid: String) -> NSPredicate {
        return NSPredicate(format: "%K == %@", #keyPath(User.uid), uid)
    }
    
    public static func sendRequest(fromUID: String, toUID: String, fromParam: [String:Any], toParam: [String:Any], success:@escaping ()->(), failure:@escaping (Error)->()) {
        
        let group = DispatchGroup()
        group.enter()
        FireDatabase.sentRequest(fromUid: fromUID, toUid: toUID).reference.setValue(toParam) { (error, _) in
            group.leave()
            guard error == nil else {
                failure(error!)
                return
            }
        }
        
        group.enter()
        FireDatabase.receivedRequest(fromUid: toUID, toUid: fromUID).reference.setValue(fromParam) { (error, _) in
            group.leave()
            guard error == nil else {
                failure(error!)
                return
            }
        }
        group.notify(queue: DispatchQueue.main, execute: success)
    }
    
    // MARK: - Fileprivate
    
    @NSManaged fileprivate var primitiveIsFavorite: Bool
    
    fileprivate func getValueForPrivateAndName()->String {
        return "\(isPrivate)\(name)"
    }
    
}

extension User {
    
}




















