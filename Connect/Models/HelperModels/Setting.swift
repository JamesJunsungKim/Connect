//
//  Setting.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

enum SettingType {
    case contact
    case notification
    case data
    case help
    case invite
    
    var indexPath: IndexPath {
        switch self {
        case .contact: return IndexPath(row: 0, section: 1)
        case .notification: return IndexPath(row: 1, section: 1)
        case .data: return IndexPath(row: 2, section: 1)
        case .help: return IndexPath(row: 0, section: 2)
        case .invite: return IndexPath(row: 1, section: 2)
        }
    }
}

struct Setting {
    let type: SettingType
    let imageName: String
    let title: String
    
    public static func fetchDefaultSettings() -> [Setting] {
        return [
            Setting(type: .contact, imageName: "contact_setting", title: "Contacts"),
            Setting(type: .notification, imageName: "notification_setting", title: "Notification"),
            Setting(type: .data, imageName: "data_setting", title: "Data Usage"),
            Setting(type: .help, imageName: "help_setting", title: "Help"),
            Setting(type: .invite, imageName: "invite_setting", title: "Invite your friends")
        ]
    }
    
    
    
    
    
    
}








