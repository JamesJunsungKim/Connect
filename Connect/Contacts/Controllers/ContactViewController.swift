//
//  ContactViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class ContactViewController: UIViewController, UserInvolvedController {
    
    // UI
    
    fileprivate var tableview: UITableView!
    
    public var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVC()
    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Filepriavte
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Contacts"
    }
    
    
}


extension ContactViewController {
    fileprivate func setupUI() {
        tableview = UITableView(frame: .zero, style: .plain)
        
        
        
        
        
        
        
    }
}








