//
//  GlobalProperty.swift
//  Connect
//
//  Created by James Kim on 5/12/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit


var isTesting = false {
    didSet {
        countForFlag += 1
        guard countForFlag != 2 else {fatalError()}
    }
}
private var countForFlag = 0

//private let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//let mainContext = appDelegate.persistentContainer.viewContext

var viewControllerMemoryArray: [String] = []
var referenceMemeoryDictionary : [String:[String:String?]] = [:]


