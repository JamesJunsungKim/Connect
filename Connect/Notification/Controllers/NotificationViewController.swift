//
//  NotificationViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class NotificationViewController: UIViewController {
    
    // UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
        
    }
    
    deinit {
        leaveViewControllerMomeryLogAndSaveDataToDisk(type: self.classForCoder)
    }
    
    //MARK: - Filepriavte
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Notification"
    }
    
}

extension NotificationViewController {
    
    fileprivate func setupUI() {
        
        
        
        
        
        
        
        
    }
}










