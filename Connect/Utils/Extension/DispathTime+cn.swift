//
//  DispathTime+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import Foundation

extension DispatchTime {
    static func waitFor(milliseconds: Int, completion: @escaping () -> ()) {
        let deadlineTime = DispatchTime.now() + .milliseconds(milliseconds)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            completion()
        }
    }
}
