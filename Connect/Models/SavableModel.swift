//
//  SavableModel.swift
//  Connect
//
//  Created by James Kim on 5/12/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData
import FirebaseStorage
import ARSLineProgress

protocol SavableModel: BaseModel {
    static var storageRefernece: StorageReference {get}
}


extension SavableModel {
    
    static func upload(data: Data, success: @escaping (String)->(), failure: @escaping (Error)->()) {
        _ = storageRefernece.putData(data, metadata: nil) { (metadata, error) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return}
            
            storageRefernece.downloadURL(completion: { (url, error) in
                guard let url = url, error == nil else {
                    logError(error!.localizedDescription)
                    failure(error!)
                    return
                }
                success(url.absoluteString)
            })
        }
    }
}














