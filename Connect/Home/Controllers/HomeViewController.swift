//
//  HomeViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UserInvolvedController {
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterMemoryLog(type: self.classForCoder)
        setupViewController()
        setupNavigationBar()
        
    }
    deinit {
        leaveMomeryLog(type: self.classForCoder)
    }
    
    //MARK: - Filepriavte
    
    fileprivate func setupViewController() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Home"
    
    }
    
    
}












