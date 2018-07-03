//
//  GlobalProperty.swift
//  Connect
//
//  Created by James Kim on 5/12/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit


private var countForFlag = 0
var isTesting = false {
    didSet {
        countForFlag += 1
        guard countForFlag != 2 else {fatalError()}
    }
}

var viewControllerMemoryArray: [String] = []
var referenceMemeoryDictionary : [String:[String:String?]] = [:]


