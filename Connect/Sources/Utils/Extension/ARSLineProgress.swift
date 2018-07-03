//
//  ARSLineProgress.swift
//  Connect
//
//  Created by James Kim on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import ARSLineProgress


extension ARSLineProgress {
    static func showSuccess(andThen completion:@escaping ()->()) {
        ARSLineProgress.showSuccess()
        DispatchQueue.main.waitFor(milliseconds: 1000) {
            completion()
        }
    }
}
