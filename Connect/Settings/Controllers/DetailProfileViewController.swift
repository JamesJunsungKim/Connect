//
//  DetailProfileViewController.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

class DetailProfileViewController: UIViewController {
    
    // UI
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVC()
    }
    
    // MARK: - Filepriavte
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.title = "Edit Profile"
    }
    
}

extension DetailProfileViewController {
    fileprivate func setupUI(){
        
        
        
    }
}








