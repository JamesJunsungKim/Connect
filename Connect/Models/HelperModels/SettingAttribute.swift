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

struct SettingAttribute {
    let type: SettingAttributeType
    let title: String
    var content: String?
    var description: String?
    var toggleSource: UserDefaults.Key?
    let targetIndexPath: IndexPath
    
    
    
    public static func userSettingAttributes() -> [SettingAttribute] {
        return [
            SettingAttribute(type: .label, title: "Status Message", content: "Your message will be displayed to your contacts.", description: nil,toggleSource: nil, targetIndexPath: IndexPath(row: 0, section: 0)),
            SettingAttribute(type: .label, title: "Phone Number", content: "Your phone number won't be shown to your contacts", description: nil,toggleSource:nil, targetIndexPath: IndexPath(row: 0, section: 1)),
            SettingAttribute(type: .label, title: "Email Address", content: "Email address",  description: nil,toggleSource:nil, targetIndexPath: IndexPath(row: 1, section: 1)),
            SettingAttribute(type: .toggle, title: "Make your account private", content: nil, description: "If your account is private, your account is only searchable by your email address",toggleSource:.isAccountPrivate, targetIndexPath: IndexPath(row: 0, section: 2)),
            SettingAttribute(type: .onlyAction, title: "SignOut", content: nil, description: nil,toggleSource:nil, targetIndexPath: IndexPath(row: 0, section: 3))
        ]
    }
}








