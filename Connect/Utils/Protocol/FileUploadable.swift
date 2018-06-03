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

protocol FileUploadable: CompletionHandler {}

extension FileUploadable {
    static func upload(fileData: Data, toStorage reference: StorageReference ,success: @escaping (String)->(), failure: @escaping (Error)->()) {
        _ = reference.putData(fileData, metadata: nil) { (metadata, error) in
            guard error == nil else {
                logError(error!.localizedDescription)
                failure(error!)
                return}
            
            reference.downloadURL(completion: { (url, error) in
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














