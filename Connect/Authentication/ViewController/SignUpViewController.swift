//
//  SignUpViewController.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    //MARK: - UI
    fileprivate var facebookLoginButton: UIButton!
    fileprivate var nameTextField: UITextField!
    fileprivate var emailTextField: UITextField!
    fileprivate var passwordTextField: UITextField!
    fileprivate var createAccountButton: UIButton!
    
    fileprivate var namePlaceHolderLabel: UILabel!
    fileprivate var emailPlaceHolderLabel: UILabel!
    fileprivate var passwordPlaceHolderLabel: UILabel!
    
    fileprivate var nameWarningLabel: UILabel!
    fileprivate var emailWarningLabel: UILabel!
    fileprivate var passwordWarningLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    
    // MARK: - Fileprivate
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        
        // navigationbar
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBtnClicked))
        navigationItem.rightBarButtonItem = cancelBtn
    }
    
    @objc fileprivate func cancelBtnClicked() {
        
    }
}

extension SignUpViewController {
    fileprivate func setupUI() {
        
        facebookLoginButton = {
            let bt = UIButton(type: .system)
            bt.backgroundColor = .clear
            bt.setTitleColor(UIColor.color(R: 68, G: 89, B: 150), for: .normal)
            let title = NSAttributedString(string: "Sign up with Facebook", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13)])
            bt.setAttributedTitle(title, for: .normal)
            return bt
        }()
        
        let facebookLogoImageView = UIImageView.create(image: UIImage(named: "facebookIcon")!)
        
        let orLabel = UILabel.create(text: "or", textAlignment: .left, textColor: .black, fontSize: 11)
        
        let orSeparatorLine = UIView.createSeparator()
        
        let nameSeparatorLine = UIView.createSeparator()
        
        let emailSeparatorLine = UIView.createSeparator()
        
        let passwordSeparatorLine = UIView.createSeparator()
        
        namePlaceHolderLabel = UILabel.create(text: "Name", textAlignment: .left, textColor: .lightGray, fontSize: 19)
        
        emailPlaceHolderLabel = UILabel.create(text: "Email Address", textAlignment: .left, textColor: .lightGray, fontSize: 19)
        
        passwordPlaceHolderLabel = UILabel.create(text: "Password", textAlignment: .left, textColor: .lightGray, fontSize: 19)
        
        nameWarningLabel = UILabel.create(text: "You can not leave it empty", textAlignment: .center, textColor: .red, fontSize: 14)
        
        emailWarningLabel = UILabel.create(text: "Invalid Email Address. Please check it again", textAlignment: .center, textColor: .red, fontSize: 14)
        
        passwordWarningLabel = UILabel.create(text: "Password must includ at least 6 characters", textAlignment: .center, textColor: .red, fontSize: 14)
        
        createAccountButton = {
            let bt = UIButton(type: .system)
            bt.backgroundColor = .mainBlue
            let title = NSAttributedString(string: "Sign up with Facebook", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor:UIColor.white])
            bt.setAttributedTitle(title, for: .normal)
            return bt
        }()
        
        let termAgreementLabel = UILabel.create(text: "By clicking 'Creat Account', you are agreeing to the Terms of Use and Privacy Policy of Connect.", textAlignment: .center, textColor: .lightGray, fontSize: 13)
        
        
        
        
        
        
    }
}













