//
//  NetworkSession.swift
//  Connect
//
//  Created by James Kim on 7/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol NetworkSession {
    typealias JSON = [String:Any]
    func fetch(fromNode node: DatabaseReference) -> NetworkResult<JSON,Error>
    func fetchList(fromNode node: DatabaseReference, queryOrdedByChild child: String, queryEqualTo value: Any?) -> NetworkResult<[JSON],Error>
    func post(value: JSON, toNode node: DatabaseReference) -> NetworkResult<Void,Error>
    func patch(value: JSON, toNode node: DatabaseReference) -> NetworkResult<Void,Error>
}

extension NetworkSession{
    
    
}
