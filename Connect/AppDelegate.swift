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

    fileprivate var persistentContainer: NSPersistentContainer!
    
    fileprivate var mainWindow: UIWindow?
    fileprivate var signupWindow: UIWindow?
    fileprivate var textWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        UserDefaults.removeValue(forKey: .uidForSignedInUser)
        
        setFlag()
        setupCoreStack()
        setupFirebase()
        setupThirdPartyLogin(application:application, launchOptions: launchOptions)
        setupScreenAndRootVC()
        
        let a: (UIImage)-> () = {_ in }
        testMode(targetVC: MasterAlbumViewController(photoSelectAction: a))
        return true
    }
    
    //MARK: - Public
    public func switchToMainWindow(user: User) {
        let appStatus = AppStatus(currentUser: user, mainContext: persistentContainer.viewContext)
        mainWindow = UIWindow(frame: UIScreen.main.bounds)
        mainWindow?.makeKeyAndVisible()
        mainWindow?.windowLevel = UIWindowLevelAlert
        mainWindow?.rootViewController = MainTabBarController(appStatus: appStatus)
        
        signupWindow = nil
    }
    
    public func switchToSignUpWindow() {
        signupWindow = UIWindow(frame: UIScreen.main.bounds)
        signupWindow?.makeKeyAndVisible()
        signupWindow?.windowLevel = UIWindowLevelAlert
        
        signupWindow?.rootViewController = UINavigationController.createDefaultNavigationController(rootViewController: WalkThroughViewController(context: persistentContainer.viewContext) )
        
        mainWindow = nil
    }
    
    //MARK: - Private
    private func setupScreenAndRootVC() {
        if UserDefaults.checkIfValueExist(forKey: .uidForSignedInUser) {
            let uid = (UserDefaults.retrieveValueOrFatalError(forKey: .uidForSignedInUser) as! String)
            let user = User.findOrFetch(forUID: uid, fromMOC: persistentContainer.viewContext)!
            switchToMainWindow(user: user)
        } else {
            switchToSignUpWindow()
        }
    }
    
    private func setupCoreStack() {
        createConnectContainer {[unowned self] (container) in
            self.persistentContainer = container
        }
    }
    
    private func setupFirebase() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    private func setupThirdPartyLogin(application: UIApplication,launchOptions:[UIApplicationLaunchOptionsKey: Any]?) {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func testMode(targetVC: UIViewController) {
        mainWindow = nil
        signupWindow = nil
        
        textWindow = UIWindow(frame: UIScreen.main.bounds)
        textWindow?.makeKeyAndVisible()
        textWindow?.rootViewController = targetVC
    }
    
    private func setFlag() {
        if let _ = NSClassFromString("XCTest") {
            isTesting = true
            print("\n\n\n\nTesting is running\n\n\n\n")
        }
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
        _ = persistentContainer.viewContext.saveOrRollback()
    }


}

