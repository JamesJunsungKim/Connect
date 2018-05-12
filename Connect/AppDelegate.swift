//
//  AppDelegate.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var persistentContainer: NSPersistentContainer!
    
    fileprivate var mainWindow: UIWindow?
    fileprivate var signupWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        setupCoreStack()
        setupFirebase()
        setupThirdPartyLogin(application:application,launchOptions: launchOptions)
        setupScreenAndRootVC()
//        testMode(targetVC: SetupDetailAccountViewController())
        return true
    }
    
    //MARK: - Public
    public func switchToMainWindow() {
        mainWindow?.makeKeyAndVisible()
    }
    
    public func switchToSignUpWindow() {
        signupWindow?.makeKeyAndVisible()
    }
    
    //MARK: - Private
    private func setupScreenAndRootVC() {
        mainWindow = UIWindow(frame: UIScreen.main.bounds)
        signupWindow = UIWindow(frame: UIScreen.main.bounds)

        let mainTabbarController = MainTabBarController()
        mainTabbarController.context = persistentContainer.viewContext
        mainWindow?.rootViewController = mainTabbarController
        mainWindow?.makeKeyAndVisible()

        if !UserDefaults.checkIfValueExist(forKey: .uidForSignedInUser) {
            let nav = UINavigationController(rootViewController: WalkThroughViewController())
            nav.navigationBar.setupToMainBlueTheme(withLargeTitle: false)

            signupWindow?.rootViewController = nav
            signupWindow?.makeKeyAndVisible()
        }
    }
    
    private func setupCoreStack() {
        createConnectContainer {[unowned self] (container) in
            self.persistentContainer = container
        }
    }
    
    private func setupFirebase() {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
    }
    
    private func setupThirdPartyLogin(application: UIApplication,launchOptions:[UIApplicationLaunchOptionsKey: Any]?) {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func testMode(targetVC: UIViewController) {
        mainWindow = UIWindow(frame: UIScreen.main.bounds)
        mainWindow?.makeKeyAndVisible()
        mainWindow?.rootViewController = targetVC
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

