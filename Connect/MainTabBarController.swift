//
//  ViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    public var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        setupViewControllers()
        checkSignInUserAndFetchAndSaveToAppStatus()
        setupObservers()
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupTabbar() {
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.shadowImage = UIImage()
        self.delegate = self
    }
    
    fileprivate func setupObservers() {
        // observe a node deleted from setnRequest (cuz it will be deleted when the user accepts or disapprove it)
        
        // observe a node added to receivedReques to notify user of the request.
        FireDatabase.receivedRequests(uid: AppStatus.observer.currentUser.uid!).reference.observe(.childAdded) { (snapshot) in
            let result = snapshot.value as! [String:[String:Any]]
//            User.convertAndCreate(fromJSON: <#T##JSON#>, into: <#T##NSManagedObjectContext#>, completion: <#T##(User) -> ()#>, failure: <#T##(Error) -> ()#>)
        }
        // observe all uids from contacts for status & name change.
        
        
    }
    
    fileprivate func setupViewControllers() {
        let homeNav = templatenavController(unselected: #imageLiteral(resourceName: "home_unselected"), selected: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeViewController(), withLargetitle: false)
        let contactNav = templatenavController(unselected: #imageLiteral(resourceName: "contacts_unselected"), selected: #imageLiteral(resourceName: "contacts_selected"), rootViewController: ContactViewController(), withLargetitle: false)
        let messageNav = templatenavController(unselected: #imageLiteral(resourceName: "message_unselected"), selected: #imageLiteral(resourceName: "message_selected"), rootViewController: MessageViewController(), withLargetitle: false)
        let notificationNav = templatenavController(unselected: #imageLiteral(resourceName: "notification_unselected"), selected: #imageLiteral(resourceName: "notification_selected"), rootViewController: NotificationViewController(), withLargetitle: false)
        let settingsNav = templatenavController(unselected: #imageLiteral(resourceName: "settings_unselected"), selected: #imageLiteral(resourceName: "settings_selected"), rootViewController: SettingsViewController(), withLargetitle: false)
        
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
    
    fileprivate func checkSignInUserAndFetchAndSaveToAppStatus() {
        guard UserDefaults.checkIfValueExist(forKey: .uidForSignedInUser), AppStatus.observer.currentUser != nil else {
            AppStatus.observer.currentUser = User.fetchSignedInUser()
            return}
    }
}






















