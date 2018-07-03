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
}

struct Setting {
    let type: SettingType
    let imageName: String
    let title: String
    let indexPath: IndexPath
    
    public static func fetchDefaultSettings() -> [Setting] {
        return [
            Setting(type: .contact, imageName: "contact_setting", title: "Contacts", indexPath: IndexPath(row: 0, section: 1)),
            Setting(type: .notification, imageName: "notification_setting", title: "Notification", indexPath: IndexPath(row: 1, section: 1)),
            Setting(type: .data, imageName: "data_setting", title: "Data Usage", indexPath: IndexPath(row: 2, section: 1)),
            Setting(type: .help, imageName: "help_setting", title: "Help", indexPath: IndexPath(row: 0, section: 2)),
            Setting(type: .invite, imageName: "invite_setting", title: "Invite your friends", indexPath: IndexPath(row: 1, section: 2))
        ]
    }
    
    
    
    
    
    
}








