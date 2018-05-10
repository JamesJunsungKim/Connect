//
//  URL.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension URL {
    static var temporary: URL {
        return URL(fileURLWithPath:NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(UUID().uuidString)
    }
    
    static var documents: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}
