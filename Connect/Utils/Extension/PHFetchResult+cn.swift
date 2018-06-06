//
//  PHFetchOption.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Photos

extension PHFetchOptions {
    static var sampleFetchOptions : PHFetchOptions = {
        let sampleOption = PHFetchOptions()
        sampleOption.fetchLimit = 3
        sampleOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return sampleOption
    }()
}
