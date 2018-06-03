//
//  PHFetchOption.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Photos

extension PHFetchOptions {
    static func sampleFetch() -> PHFetchOptions {
        let option = PHFetchOptions()
        option.fetchLimit = 3
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return option
    }
}
