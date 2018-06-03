//
//  UUID+cn.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension UUID {
    public static func create() -> String {
        return UUID().uuidString
    }
}
