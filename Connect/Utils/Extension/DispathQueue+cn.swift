//
//  DispathTime+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import Foundation

extension DispatchQueue{
    static func performOnMain(block:@escaping ()->()) {
        DispatchQueue.main.async(execute: block)
    }
    
    static func performOnBackground(block:@escaping()->()) {
        DispatchQueue.global(qos: .background).async(execute: block)
    }
    
}

extension DispatchTime {
    static func waitFor(milliseconds: Int, completion: @escaping () -> ()) {
        let deadlineTime = DispatchTime.now() + .milliseconds(milliseconds)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            completion()
        }
    }
}
