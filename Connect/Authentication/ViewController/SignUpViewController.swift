//
//  SignUpViewController.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit
import ARSLineProgress

class SignUpViewController: UIViewController {
    
    //MARK: - UI
    fileprivate var facebookSignUpButton: UIButton!
    fileprivate var thirdPartyLoginView: UIView!
    
    fileprivate var orLabel: UILabel!
    fileprivate var nameSeparatorLine: UIView!
    fileprivate var emailSeparatorLine: UIView!
    fileprivate var passwordSeparatorLine: UIView!
    
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
        enterViewControllerMemoryLogAndSaveToDisk(type: self.classForCoder)
        setupUI()
        setupVC()
        addTargets()
        
    }
    deinit {
        leaveViewControllerMomeryLogAndSaveDataToDisk(type: self.classForCoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    
    
    @objc fileprivate func facebookBtnClicked() {
        // facebook account
    }
    
    @objc fileprivate func createBtnClicked() {
        ARSLineProgress.ars_showOnView(view)
        User.createAndRegister(into: mainContext, name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, completion: {[unowned self]  (user) in
            ARSLineProgress.showSuccess(andThen: {
                self.presentDefaultVC(targetVC: SetupDetailAccountViewController(), userInfo: [User.Key.user:user])
            })
        }) {[unowned self] error in
            ARSLineProgress.hideWithCompletionBlock {
                self.presentDefaultError(message: error.localizedDescription, okAction: nil)
            }
        }
    }
    
    // MARK: - Filepriavte logic part.
    fileprivate let animationDuration = 0.8
    
    fileprivate var thirdPartyHeightConstraint: Constraint!
    fileprivate var nameWarningHeightConstraint: Constraint!
    fileprivate var emailWarningHeightConstraint: Constraint!
    fileprivate var passwordWarningHeightConstraint: Constraint!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapview))
        view.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func addTargets() {
        nameTextField.addTarget(self, action: #selector(nameTextFieldEditingDidBegin), for: .editingDidBegin)
        nameTextField.addTarget(self, action: #selector(nameTextFieldEditingDidEnd), for: .editingDidEnd)
        nameTextField.addTarget(self, action: #selector(enableOrDisableCreatButton), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldEditingDidBegin), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(emailTextFieldEditingDidEnd), for: .editingDidEnd)
        emailTextField.addTarget(self, action: #selector(enableOrDisableCreatButton), for: .editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingDidBegin), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingDidEnd), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(enableOrDisableCreatButton), for: .editingChanged)
        
        createAccountButton.addTarget(self, action: #selector(createBtnClicked), for: .touchUpInside)
    }
    
    fileprivate func showOrHideThirdPartyLoginView(shouldHide flag: Bool) {
        if flag {
            UIView.animate(withDuration: 1) {[unowned self] in
                self.thirdPartyLoginView.alpha = 0
                self.orLabel.alpha = 0
                self.thirdPartyHeightConstraint.update(offset: 50)
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
                self.thirdPartyLoginView.alpha = 1
                self.orLabel.alpha = 1
                self.thirdPartyHeightConstraint.update(offset: 95)
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc fileprivate func userDidTapview() {
        showOrHideThirdPartyLoginView(shouldHide: false)
    }
    
    @objc fileprivate func enableOrDisableCreatButton() {
        if validateName() {
            showOrHideNameWarningLabel(nameIsValid: validateName())
        }
        
        if validateEmail() {
            showOrHideEmailWarningLabel(emailIsValid: validateEmail())
        }
        
        if validatePassword() {
            showOrHidePasswordWarningLabel(passwordIsValid: validatePassword())
        }
        
        _ = checkIfReadyToMoveToNextPage()
    }
    
    @objc fileprivate func nameTextFieldEditingDidBegin() {
        showOrHideThirdPartyLoginView(shouldHide: true)
        placeHolderBeginningAnimation(label: namePlaceHolderLabel, bottomView: nameSeparatorLine, leadingMargin: 58, bottomMargin: 35)
       
    }
    @objc fileprivate func nameTextFieldEditingDidEnd() {
        showOrHideNameWarningLabel(nameIsValid: validateName())
        placeHolderEndingAnimation(textField: nameTextField, label: namePlaceHolderLabel, bottomView: nameSeparatorLine, leadingMargin: 75, bottomMargin: 5)
    }
    
    @objc fileprivate func emailTextFieldEditingDidBegin() {
        showOrHideThirdPartyLoginView(shouldHide: true)
        placeHolderBeginningAnimation(label: emailPlaceHolderLabel, bottomView: emailSeparatorLine, leadingMargin: 56.5, bottomMargin: 35)
    }
    
    @objc fileprivate func emailTextFieldEditingDidEnd() {
        showOrHideEmailWarningLabel(emailIsValid: validateEmail())
        placeHolderEndingAnimation(textField: emailTextField, label: emailPlaceHolderLabel, bottomView: emailSeparatorLine, leadingMargin: 75, bottomMargin: 5)
    }
    
    @objc fileprivate func passwordTextFieldEditingDidBegin() {
        showOrHideThirdPartyLoginView(shouldHide: true)
        placeHolderBeginningAnimation(label: passwordPlaceHolderLabel, bottomView: passwordSeparatorLine, leadingMargin: 58, bottomMargin: 35)
    }
    
    @objc fileprivate func passwordTextFieldEditingDidEnd() {
        showOrHidePasswordWarningLabel(passwordIsValid: validatePassword())
        placeHolderEndingAnimation(textField: passwordTextField, label: passwordPlaceHolderLabel, bottomView: passwordSeparatorLine, leadingMargin: 75, bottomMargin: 5)
    }
    
    fileprivate func validateName()-> Bool {
        return nameTextField.hasText
    }
    
    fileprivate func showOrHideNameWarningLabel(nameIsValid isValid: Bool) {
        UIView.animate(withDuration: animationDuration ) {
            self.nameWarningLabel.alpha = isValid ? 0 : 1
            self.nameWarningHeightConstraint.update(offset: isValid ? 0 : 30)
        }
    }

    fileprivate func validateEmail()->Bool {
        return emailTextField.text!.validateForEmail()
    }
    
    fileprivate func showOrHideEmailWarningLabel(emailIsValid isValid: Bool) {
        UIView.animate(withDuration: animationDuration ) {
            self.emailWarningLabel.alpha = isValid ? 0 : 1
            self.emailWarningHeightConstraint.update(offset: isValid ? 0 : 30)
        }
    }
    
    fileprivate func validatePassword()->Bool {
        return passwordTextField.text!.count > 5
    }
    
    fileprivate func showOrHidePasswordWarningLabel(passwordIsValid isValid: Bool) {
        UIView.animate(withDuration: animationDuration ) {
            self.passwordWarningLabel.alpha = isValid ? 0 : 1
            self.passwordWarningHeightConstraint.update(offset: isValid ? 0 : 30)
        }
    }
    
    fileprivate func checkIfReadyToMoveToNextPage()->Bool {
        let isValid = validateName() && validateEmail() && validatePassword()
        createAccountButton.isEnabled = isValid
        return isValid
    }
    
}

extension SignUpViewController:DefaultSegue {
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {/*no-op*/}
}

extension SignUpViewController {
    fileprivate func setupUI() {
        
        facebookSignUpButton = {
            let bt = UIButton(type: .system)
            bt.backgroundColor = .clear
            let title = NSAttributedString(string: "Sign up with Facebook", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor:UIColor.color(R: 68, G: 89, B: 150)])
            bt.setAttributedTitle(title, for: .normal)
            bt.addTarget(self, action: #selector(facebookBtnClicked), for: .touchUpInside)
            return bt
        }()
        
        let facebookLogoImageView = UIImageView.create(withImageName: "facebookIcon")
        
        orLabel = UILabel.create(text: "or", textAlignment: .center, textColor: .black, fontSize: 13)
        orLabel.backgroundColor = .white
        
        let orSeparatorLine = UIView.create()
        
        nameSeparatorLine = UIView.create()
        
        emailSeparatorLine = UIView.create()
        
        passwordSeparatorLine = UIView.create()
        
        nameTextField = UITextField.create(placeHolder: "", textSize: 17, textColor: .black, keyboardType: .default)
        
        emailTextField = UITextField.create(placeHolder: "", textSize: 17, textColor: .black, keyboardType: .default)
        
        passwordTextField = UITextField.create(placeHolder: "", textSize: 17, textColor: .black, keyboardType: .default)
        passwordTextField.isSecureTextEntry = true
        
        namePlaceHolderLabel = UILabel.create(text: "Name", textAlignment: .left, textColor: .lightGray, fontSize: 19)
        
        emailPlaceHolderLabel = UILabel.create(text: "Email Address", textAlignment: .left, textColor: .lightGray, fontSize: 19)
        
        passwordPlaceHolderLabel = UILabel.create(text: "Password", textAlignment: .left, textColor: .lightGray, fontSize: 19)
        
        nameWarningLabel = UILabel.create(text: "You can't leave it empty. Please enter your name", textAlignment: .left, textColor: .red, fontSize: 14)
        
        emailWarningLabel = UILabel.create(text: "Invalid Email Address. Please check it again", textAlignment: .left, textColor: .red, fontSize: 14)
        
        passwordWarningLabel = UILabel.create(text: "Password must includ at least 6 characters", textAlignment: .left, textColor: .red, fontSize: 14)
        
        createAccountButton = {
            let bt = UIButton(type: .system)
            bt.backgroundColor = .mainBlue
            bt.setCornerRadious(value: 10)
            let title = NSAttributedString(string: "Create Account", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:UIColor.white])
            bt.setAttributedTitle(title, for: .normal)
            bt.isEnabled = false
            return bt
        }()
        
        let termAgreementLabel = UILabel.create(text: "By clicking 'Creat Account', you are agreeing to the Terms of Use and Privacy Policy of Connect.", textAlignment: .center, textColor: .lightGray, fontSize: 13)
        
        let facebookStackView = UIStackView.create(views: [facebookLogoImageView, facebookSignUpButton], axis: .horizontal, alignment: .center, distribution: .equalSpacing, spacing: 5)
        
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
            make.height.equalTo(20)
        }
        
        facebookLogoImageView.fitTo(size: CGSize(width: 20, height: 20))
        
        orLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(orSeparatorLine)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        orSeparatorLine.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
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
            make.bottom.equalTo(nameSeparatorLine.snp.top).offset(-5)
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
            self.nameWarningHeightConstraint = make.height.equalTo(0).constraint
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameWarningLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(30)
        }
        
        emailPlaceHolderLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(75)
            make.bottom.equalTo(emailSeparatorLine.snp.top).offset(-5)
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
            self.emailWarningHeightConstraint = make.height.equalTo(0).constraint
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailWarningLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(30)
        }
        
        passwordPlaceHolderLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(75)
            make.bottom.equalTo(passwordSeparatorLine.snp.top).offset(-5)
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
            self.passwordWarningHeightConstraint = make.height.equalTo(0).constraint
        }
        
        createAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordWarningLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        termAgreementLabel.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(40)
        }
        
        
        
        
        
        
        
        
        
    }
}













