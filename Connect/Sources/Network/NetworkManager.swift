//
//  NetworkManager.swift
//  Connect
//
//  Created by James Kim on 7/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

class NetworkManager {
    private(set) var session: NetworkSession
    
    init(session:NetworkSession) {
        self.session = session
    }
    
    public func fetch() {
    }
    
    public func fetchList() {}
    
    public func post() {}
    
    public func postFiles() {}
    
    public func patch() {}
    
    public func delete() {}
    
}
