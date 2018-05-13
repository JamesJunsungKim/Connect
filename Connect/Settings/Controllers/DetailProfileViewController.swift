//
//  DetailProfileViewController.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

class DetailProfileViewController: UIViewController, UserInvolvedController {
    
    // UI
    fileprivate var profileView: UIView!
    fileprivate var profileButton: UIButton!
    fileprivate var nameLabel: UILabel!
    
    
    
    public var user: User!
    
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

extension DetailProfileViewController:DefaultViewController {
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        user = User.unwrapFrom(userInfo: userInfo!)
    }
    fileprivate func setupUI(){
        profileView = UIView.create(withColor: .white)
        
        profileButton = UIButton.create(withImageName: "profile_image")
        nameLabel = UILabel.create(text: "Name", textAlignment: .center, textColor: .black, fontSize: 15, numberofLine: 1)
        
        let group: [UIView] = [profileButton, nameLabel]
        group.forEach(profileView.addSubview(_:))
        
        profileButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        
        
        
    }
    
}








