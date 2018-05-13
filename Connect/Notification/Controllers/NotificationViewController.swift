//
//  NotificationViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class NotificationViewController: UIViewController, UserInvolvedController {
    
    public var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupNavigationBar()
        
    }
    
    //MARK: - Filepriavte
    fileprivate func setupVC() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Notification"
    }
}
