//
//  ViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData

protocol UserInvolvedController:AnyObject {
    var user: User! {get set}
}

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    public var context: NSManagedObjectContext!
    public var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        setupViewControllers()
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        checkSignInUserAndFetch()
        guard let nav = viewController as? UINavigationController, let destination = nav.viewControllers.first as? UserInvolvedController else {fatalError()}
        destination.user = currentUser
        return true
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupTabbar() {
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.shadowImage = UIImage()
        self.delegate = self
    }
    
    fileprivate func setupViewControllers() {
        let homeNav = templatenavController(unselected: #imageLiteral(resourceName: "home_unselected"), selected: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeViewController(), withLargetitle: true)
        let contactNav = templatenavController(unselected: #imageLiteral(resourceName: "contacts_unselected"), selected: #imageLiteral(resourceName: "contacts_selected"), rootViewController: ContactViewController(), withLargetitle: true)
        let messageNav = templatenavController(unselected: #imageLiteral(resourceName: "message_unselected"), selected: #imageLiteral(resourceName: "message_selected"), rootViewController: MessageViewController(), withLargetitle: false)
        let notificationNav = templatenavController(unselected: #imageLiteral(resourceName: "notification_unselected"), selected: #imageLiteral(resourceName: "notification_selected"), rootViewController: NotificationViewController(), withLargetitle: true)
        let settingsNav = templatenavController(unselected: #imageLiteral(resourceName: "settings_unselected"), selected: #imageLiteral(resourceName: "settings_selected"), rootViewController: SettingsViewController(), withLargetitle: true)
        
        viewControllers = [homeNav, contactNav, messageNav, notificationNav, settingsNav]
    }

    fileprivate func templatenavController(unselected: UIImage, selected: UIImage, rootViewController: UIViewController, withLargetitle flag: Bool)-> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.setupToMainBlueTheme(withLargeTitle: flag)
        
        let tbItem = navController.tabBarItem
        tbItem?.image = unselected
        tbItem?.selectedImage = selected
        tbItem?.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return navController
    }
    
    fileprivate func checkSignInUserAndFetch() {
        guard UserDefaults.checkIfValueExist(forKey: .uidForSignedInUser) else {return}
        guard currentUser != nil else {
            currentUser = User.fetchSignedInUser()
            return
        }
    }
}






















