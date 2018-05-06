//
//  ConnectStack.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData

private let ubiquityToken: String = {
    guard let token = FileManager.default.ubiquityIdentityToken else { return "unknown" }
    let string = NSKeyedArchiver.archivedData(withRootObject: token).base64EncodedString(options: [])
    return string.removingCharacters(in: CharacterSet.letters.inverted)
}()

private let storeURL = URL.documents.appendingPathComponent("\(ubiquityToken).connect")

private let connectContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Connect", managedObjectModel: ConnectModelVersion.current.managedObjectModel())
    let storeDescription = NSPersistentStoreDescription(url: storeURL)
    container.persistentStoreDescriptions = [storeDescription]
    return container
}()

public func createConnectContainer(migrating: Bool = false, progress: Progress? = nil, completion: @escaping (NSPersistentContainer)->()) {
    
    connectContainer.loadPersistentStores(completionHandler: {_, error in
        if error == nil {
            DispatchQueue.main.async {completion(connectContainer)}
        } else {
            guard !migrating else {fatalError("was unable to migrate store")}
            migrateStore(from: storeURL, to: storeURL, targetVersion: ConnectModelVersion.current, deleteSource: true, progress: progress)
            createConnectContainer(migrating: true, progress: progress, completion: completion)
        }
    })
    
    
    
    
    
}
