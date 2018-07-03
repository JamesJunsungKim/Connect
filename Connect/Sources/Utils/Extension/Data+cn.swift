//
//  Data+cn.swift
//  Connect
//
//  Created by James Kim on 6/30/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension Data {
    func cn_MD5Hash() -> String {
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        _ = withUnsafeBytes({CC_MD5($0, CC_LONG(self.count), result)})

        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate()
        
        return String(format: hash as String)
    }
}

extension NSData {
    func cn_MD5Hash() -> String {
        return (self as Data).cn_MD5Hash()
    }
}
