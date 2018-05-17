//
//  BaseModel.swift
//  Connect
//
//  Created by James Kim on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData
import FirebaseDatabase
import SwiftyJSON

protocol BaseModel:Unwrapable {}


extension BaseModel {
    
    static func list(from reference:DatabaseReference, completion:@escaping([Self])->(), onFailed failure: @escaping(Error)->Void) {
        logInfo("List request for \(Self.self)")
        reference.observeSingleEvent(of: .value) { (snapshot) in
            guard let dics = snapshot.value as? [JSON] else {fatalError("wrong format of data")}
            do {
//                let items = try dics.map{try Self(json:$0)}
//                completion(items)
            } catch let error {
                logError(error.localizedDescription)
                failure(error)
            }
        }
    }
    
    
    static func prettyJSON(with dictionary: [String: Any]) -> String {
        var dic = dictionary
        dic.keys.forEach({
            if dic[$0] is UIImage {dic.updateValue("Image", forKey: $0)}
        })
        let result = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        let string = String(data: result, encoding: String.Encoding.utf8)
        return string.unwrapOrBlank()
    }
}




