//
//  MessageDetailViewController.swift
//  Connect
//
//  Created by James Kim on 5/29/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit


class MessageDetailViewController: UIViewController{
    
    //UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()  
        setupVC()
        addTargets()
    }
    
    // MARK: - Public
    
    // MARK: - Actions
    
    // MARK: - Filepriavte
    fileprivate weak var targetUser: User!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
    }
    
    fileprivate func addTargets() {
        
    }
    
    
}

extension MessageDetailViewController: DefaultViewController {
    
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        targetUser = User.unwrapFrom(userInfo: userInfo)
        
    }
    
    fileprivate func setupUI() {
        
        
        
        
        
        
        
        
    }
    
    
}











