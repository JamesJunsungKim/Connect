//
//  UpdateTimestampable.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import Foundation

let UpdateTimestampKey = "updatedAt"

protocol UpdateTimestampable: class {
    var updatedAt: Date { get set }
}
