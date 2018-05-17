//
//  SettingAttribute.swift
//  Connect
//
//  Created by James Kim on 5/14/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

enum SettingAttributeType{
    case label
    case toggle
    case onlyAction
}

enum SettingContentType {
    case name
    case status
    case email
    case phoneNumber
    case isAccountPrivate
    case auctionNotRequired
}

struct SettingAttribute:Unwrapable, Equatable {
    let type: SettingAttributeType
    let title: String
    var content: String?
    let contentType: SettingContentType
    var description: String?
    var toggleSource: UserDefaults.Key?
    var maximumLimit: Int?
    let targetIndexPath: IndexPath
    
    struct Key {
        static let settingAttribute = "SettingAttribute"
    }
    
    static func ==(lhs: SettingAttribute, rhs: SettingAttribute) -> Bool {
        return lhs.title == rhs.title
    }
}








