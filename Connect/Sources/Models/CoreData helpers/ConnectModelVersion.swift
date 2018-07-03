//
//  ConnectModelVersion.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData

enum ConnectModelVersion: String {
    case version1 = "Connect"
}

extension ConnectModelVersion: ModelVersion {
    static var all: [ConnectModelVersion] {return [.version1]}
    
    static var current: ConnectModelVersion {return .version1}
    
    var name: String {return rawValue}
    
    var modelBundle: Bundle {return Bundle.main}
    
    var modelDirectoryName: String {return "Connect.momd"}

}
