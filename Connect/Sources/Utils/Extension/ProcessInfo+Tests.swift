//
//  ProcessInfo+Tests.swift
//  Connect
//
//  Created by James Kim on 6/30/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension ProcessInfo {
    
    var isRunningTests : Bool {
        return environment["XCTestConfigurationFilePath"] != nil
    }
    
}
