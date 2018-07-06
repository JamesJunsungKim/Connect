//
//  NetworkResult.swift
//  Connect
//
//  Created by James Kim on 7/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

public enum NetworkResult<T,U> {
    case success(T)
    case failure(U)
}
