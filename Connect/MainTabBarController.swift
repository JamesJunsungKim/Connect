//
//  ViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData

class MainTabBarController: UITabBarController {
    
    public var context: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        setupViewControllers()
    }
    
    // MARK: - Fileprivate
    fileprivate func setupTabbar() {
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.shadowImage = UIImage()
    }
    fileprivate func setupViewControllers() {
        let homeNav = templatenavController(unselected: #imageLiteral(resourceName: "home_unselected"), selected: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeViewController())
        let contactNav = templatenavController(unselected: #imageLiteral(resourceName: "contacts_unselected"), selected: #imageLiteral(resourceName: "contacts_selected"), rootViewController: ContactViewController())
        let messageNav = templatenavController(unselected: #imageLiteral(resourceName: "message_unselected"), selected: #imageLiteral(resourceName: "message_selected"), rootViewController: MessageViewController())
        let notificationNav = templatenavController(unselected: #imageLiteral(resourceName: "notification_unselected"), selected: #imageLiteral(resourceName: "notification_selected"), rootViewController: NotificationViewController())
        let settingsNav = templatenavController(unselected: #imageLiteral(resourceName: "settings_unselected"), selected: #imageLiteral(resourceName: "settings_selected"), rootViewController: SettingsViewController())
        
        viewControllers = [homeNav, contactNav, messageNav, notificationNav, settingsNav]
    }

    fileprivate func templatenavController(unselected: UIImage, selected: UIImage, rootViewController: UIViewController)-> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        let nvBar = navController.navigationBar
        nvBar.barStyle = .black
        nvBar.barTintColor = UIColor.eateryBlue.navigationBarAdjusted
        nvBar.tintColor = .white
        nvBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        if #available(iOS 11.0, *) {
            nvBar.prefersLargeTitles = true
        }
        
        let tbItem = navController.tabBarItem
        tbItem?.image = unselected
        tbItem?.selectedImage = selected
        tbItem?.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return navController
    }
}






















