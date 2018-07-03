//
//  CompletionHandler.swift
//  Connect
//
//  Created by James Kim on 6/2/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

protocol CompletionHandler {
    typealias success = (Self)->()
    typealias successWithoutModel = ()->()
}
