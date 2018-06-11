//
//  PHFetchOption.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Photos

extension PHFetchOptions {
    struct Key {
        static let creationDate = "creationDate"
    }
    static func fetchOption(configure:((PHFetchOptions)->())) -> PHFetchOptions {
        let op = PHFetchOptions()
        configure(op)
        return op
    }
}
