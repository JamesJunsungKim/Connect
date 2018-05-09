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
    fileprivate var thirdPartyLoginView: UIView!
    
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
    fileprivate var thirdPartyHeightConstraint: Constraint!
    
    fileprivate var nameLeadingConstraint: Constraint!
    fileprivate var nameBottomConstraint: Constraint!
    fileprivate var nameWarningHeightConstraint: Constraint!
    
    fileprivate var emailLeadingConstraint: Constraint!
    fileprivate var emailBottomConstraint: Constraint!
    fileprivate var emailWarningHeightConstraint: Constraint!
    
    fileprivate var passwordLeadingConstraint: Constraint!
    fileprivate var passwordBottomConstraint: Constraint!
    fileprivate var passwordWarningHeightConstraint: Constraint!
    
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
        
        let orLabel = UILabel.create(text: "or", textAlignment: .center, textColor: .black, fontSize: 13)
        orLabel.backgroundColor = .white
        
        
        let orSeparatorLine = UIView.createSeparator()
        
        let nameSeparatorLine = UIView.createSeparator()
        
        let emailSeparatorLine = UIView.createSeparator()
        
        let passwordSeparatorLine = UIView.createSeparator()
        
        nameTextField = UITextField.create(placeHolder: "", textSize: 17, color: .black, keyboardType: .default)
        
        emailTextField = UITextField.create(placeHolder: "", textSize: 17, color: .black, keyboardType: .default)
        
        passwordTextField = UITextField.create(placeHolder: "", textSize: 17, color: .black, keyboardType: .default)
        passwordTextField.isSecureTextEntry = true
        
        namePlaceHolderLabel = UILabel.create(text: "Name", textAlignment: .left, textColor: .lightGray, fontSize: 19)
        
        emailPlaceHolderLabel = UILabel.create(text: "Email Address", textAlignment: .left, textColor: .lightGray, fontSize: 19)
        
        passwordPlaceHolderLabel = UILabel.create(text: "Password", textAlignment: .left, textColor: .lightGray, fontSize: 19)
        
        nameWarningLabel = UILabel.create(text: "You can not leave it empty", textAlignment: .center, textColor: .red, fontSize: 14)
        
        emailWarningLabel = UILabel.create(text: "Invalid Email Address. Please check it again", textAlignment: .center, textColor: .red, fontSize: 14)
        
        passwordWarningLabel = UILabel.create(text: "Password must includ at least 6 characters", textAlignment: .center, textColor: .red, fontSize: 14)
        
        createAccountButton = {
            let bt = UIButton(type: .system)
            bt.backgroundColor = .mainBlue
            bt.setCornerRadious(value: 10)
            let title = NSAttributedString(string: "Create Account", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:UIColor.white])
            bt.setAttributedTitle(title, for: .normal)
            return bt
        }()
        
        let termAgreementLabel = UILabel.create(text: "By clicking 'Creat Account', you are agreeing to the Terms of Use and Privacy Policy of Connect.", textAlignment: .center, textColor: .lightGray, fontSize: 13)
        
        let facebookStackView : UIStackView = {
            let stv = UIStackView()
            stv.axis = .horizontal
            stv.spacing = 0
            stv.addArrangedSubview(facebookLogoImageView)
            stv.addArrangedSubview(facebookLoginButton)
            return stv
        }()
        
        thirdPartyLoginView = {
            let v = UIView()
            let elements = [facebookStackView, orSeparatorLine, orLabel]
            elements.forEach(v.addSubview(_:))
            return v
        }()
        
        let group : [UIView] = [thirdPartyLoginView,nameTextField, namePlaceHolderLabel, nameSeparatorLine,nameWarningLabel, emailTextField, emailPlaceHolderLabel, emailSeparatorLine, emailWarningLabel, passwordTextField, passwordSeparatorLine, passwordPlaceHolderLabel, passwordWarningLabel, createAccountButton, termAgreementLabel]
        group.forEach(view.addSubview(_:))
        
        thirdPartyLoginView.snp.makeConstraints {[unowned self] (make) in
            make.left.top.right.equalTo(view.safeAreaLayoutGuide)
            self.thirdPartyHeightConstraint = make.height.equalTo(95).constraint
        }
        
        facebookStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
            make.height.equalTo(30)
        }
        
        facebookLogoImageView.fitTo(size: CGSize(width: 20, height: 20))
        
        orLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(orSeparatorLine)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        orSeparatorLine.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(5)
            make.height.equalTo(0.5)
            make.width.equalTo(90)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.top.equalTo(thirdPartyLoginView.snp.bottom).offset(30)
            make.height.equalTo(30)
        }
        
        namePlaceHolderLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(75)
            make.bottom.equalTo(nameSeparatorLine.snp.top).offset(5)
        }
        
        nameSeparatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(55)
            make.right.equalToSuperview().offset(-55)
            make.height.equalTo(1)
        }
        
        nameWarningLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameSeparatorLine.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameWarningLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(30)
        }
        
        emailPlaceHolderLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(75)
            make.bottom.equalTo(emailSeparatorLine.snp.top).offset(5)
        }
        
        emailSeparatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(3)
            make.left.equalTo(55)
            make.right.equalTo(-55)
            make.height.equalTo(1)
        }
        
        emailWarningLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailSeparatorLine.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailWarningLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(30)
        }
        
        passwordPlaceHolderLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(75)
            make.bottom.equalTo(passwordSeparatorLine.snp.top).offset(5)
        }
        
        passwordSeparatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(55)
            make.right.equalToSuperview().offset(-55)
            make.height.equalTo(1)
        }
        
        passwordWarningLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordSeparatorLine.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        createAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordWarningLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        termAgreementLabel.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountButton.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(40)
            
        }
        
        
        
        
        
        
        
        
        
    }
}













