//
//  DispathTime+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import Foundation


func performOnMain(block:@escaping block) {
    DispatchQueue.main.async(execute: block)
}

func performOnBackground(block:@escaping block) {
    DispatchQueue.global(qos: .background).async(execute: block)
}

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

extension DispatchQueue {
    func waitFor(milliseconds: Int, completion: @escaping ()->()) {
        let deadlineTime = DispatchTime.now() + .milliseconds(milliseconds)
        self.asyncAfter(deadline: deadlineTime, execute: completion)
    }
}
