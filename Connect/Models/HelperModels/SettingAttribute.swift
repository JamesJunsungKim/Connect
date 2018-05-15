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
    case status
    case email
    case phoneNumber
    case isAccountPrivate
    case auctionNotRequired
}

struct SettingAttribute {
    let type: SettingAttributeType
    let title: String
    var content: String?
    let contentType: SettingContentType
    var description: String?
    var toggleSource: UserDefaults.Key?
    let targetIndexPath: IndexPath
    
    public static func userSettingAttributes() -> [SettingAttribute] {
        return [
            SettingAttribute(type: .label, title: "Status Message", content: "Your message will be displayed to your contacts.", contentType: .status, description: nil,toggleSource: nil, targetIndexPath: IndexPath(row: 0, section: 0)),
            SettingAttribute(type: .label, title: "Phone Number", content: "Your phone number won't be shown to your contacts", contentType: .phoneNumber, description: nil, toggleSource:nil, targetIndexPath: IndexPath(row: 0, section: 1)),
            SettingAttribute(type: .label, title: "Email Address", content: "Email address", contentType: .email,  description: nil,toggleSource:nil, targetIndexPath: IndexPath(row: 1, section: 1)),
            SettingAttribute(type: .toggle, title: "Make your account private", content: nil, contentType: .isAccountPrivate, description: "If your account is private, your account is only searchable by your email address",toggleSource:.isAccountPrivate, targetIndexPath: IndexPath(row: 0, section: 2)),
            SettingAttribute(type: .onlyAction, title: "SignOut", content: nil,  contentType: .auctionNotRequired, description: nil, toggleSource:nil, targetIndexPath: IndexPath(row: 0, section: 3))
        ]
    }
}








