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
import SwiftyJSON

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    init(appStatus: AppStatus) {
        self.appStatus = appStatus
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        setupViewControllers()
        setupObservers(forAppStatus: appStatus)
    }
    
    // MARK: - Public/Intenral
    public let appStatus: AppStatus
    
    // MARK: - Fileprivate
    
    fileprivate func setupTabbar() {
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.shadowImage = UIImage()
        self.delegate = self
    }
    
    fileprivate func setupObservers(forAppStatus appStatus: AppStatus) {
        // observe a node deleted from setnRequest (cuz it will be deleted when the user accepts or disapprove it)

        // observe a node added to receivedReques to notify user of the request.
        FireDatabase.receivedRequests(uid: appStatus.user.uid!).reference.observe(.childAdded) { (snapshot) in
            guard let result = snapshot.value as? [String:Any] else {return}
            Request.convertAndCreate(fromJSON: JSON(result), into: appStatus.mainContext, success: {[unowned self] (request) in
                self.appStatus.user.insert(request: request, intoSentNode: false)
                self.appStatus.received(request: request)
            }, failure: {[unowned self] (error) in
                self.presentDefaultError(message: error.localizedDescription, okAction: nil)
            })
        }
        
        // Observe for completed Requests
        FireDatabase.approvedRequests(uid: appStatus.user.uid!).reference.observe(.childAdded) {(snapshot) in
            guard let result = snapshot.value as? [String:Any], let uid = result[Request.Key.uid] as? String else {return}
            
            let targetRequest = Request.findOrFetch(forUID: uid, fromMOC: appStatus.mainContext)!
            targetRequest.completedByFromUser(updatedTo: appStatus)
        }
        
        // observe all uids from contacts for status & name change.

        }
    
    
    fileprivate func setupViewControllers() {
        let homeNav = templatenavController(unselected: #imageLiteral(resourceName: "home_unselected"), selected: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeViewController(appStatus: appStatus), withLargetitle: false)
        let contactNav = templatenavController(unselected: #imageLiteral(resourceName: "contacts_unselected"), selected: #imageLiteral(resourceName: "contacts_selected"), rootViewController: ContactViewController(appStatus: appStatus), withLargetitle: false)
        let messageNav = templatenavController(unselected: #imageLiteral(resourceName: "message_unselected"), selected: #imageLiteral(resourceName: "message_selected"), rootViewController: MessageListViewController(appStatus: appStatus), withLargetitle: false)
        let notificationNav = templatenavController(unselected: #imageLiteral(resourceName: "notification_unselected"), selected: #imageLiteral(resourceName: "notification_selected"), rootViewController: NotificationViewController(appStatus: appStatus), withLargetitle: false)
        let settingsNav = templatenavController(unselected: #imageLiteral(resourceName: "settings_unselected"), selected: #imageLiteral(resourceName: "settings_selected"), rootViewController: SettingsViewController(appStatus: appStatus), withLargetitle: false)
        
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
    
//    fileprivate func checkSignInUserAndFetchAndSaveToAppStatus() {
//        guard UserDefaults.checkIfValueExist(forKey: .uidForSignedInUser), AppStatus.current.user != nil else {
//            AppStatus.current.user = User.fetchSignedInUser()
//            return}
//    }
}






















