//
//  Global.swift
//  Connect
//
//  Created by James Kim on 7/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation


func CNassertIsOnMainTrhead() {
    assert(Thread.isMainThread, "It's not on the main thread")
}


private extension Thread {
    static var isMainThread:Bool {
        return self.isMainThread
    }
}
