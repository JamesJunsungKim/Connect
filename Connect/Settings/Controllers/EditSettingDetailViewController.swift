//
//  EditSettingDetailViewController.swift
//  Connect
//
//  Created by James Kim on 5/15/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit
import ARSLineProgress

class EditSettingDetailViewController: UIViewController {
    
    // UI
    fileprivate var textField: UITextField!
    fileprivate var descriptionLabel: UILabel!
    fileprivate var textLimitLabel: UILabel!
    fileprivate var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupVC()
        addTarget()
    }
    
    deinit {
        leaveViewControllerMomeryLogAndSaveDataToDisk(type: self.classForCoder)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func saveBtnClicked() {
        ARSLineProgress.ars_showOnView(view)
        attribute.content = textField.text!
        AppStatus.current.updateSettingAttributeAndPatch(withAttribute: self.attribute, success: {[unowned self] in
            ARSLineProgress.showSuccess(andThen: { [unowned self] in
                self.navigationController?.popViewController(animated: true)
            })
            }, failure: {[unowned self] (error) in
                self.presentDefaultError(message: error.localizedDescription, okAction: nil)
        })
    }
    
    @objc fileprivate func updateLimitLabel() {
        textLimitLabel.text = updatedLetterCount(withContent: textField.text!, limitFromAttribute: attribute)
    }
    
    
    // MARK: - Fileprivate
    fileprivate var user: User {
        return AppStatus.current.user
    }
    
    fileprivate var attribute: SettingAttribute!
    fileprivate var maxCount: String!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
    }
    
    fileprivate func addTarget() {
        textField.addTarget(self, action: #selector(updateLimitLabel), for: .editingChanged)
        saveButton.addTarget(self, action: #selector(saveBtnClicked), for: .touchUpInside)
    }
    
    fileprivate func configure(withUser user: User, withAttribute attribute: SettingAttribute) {
        descriptionLabel.text = attribute.description
        
        textLimitLabel.text = updatedLetterCount(withContent: attribute.content!, limitFromAttribute: attribute)
        
        switch attribute.contentType {
        case .name:
            textField.text = user.name
        case .status:
            textField.text = user.statusMessage == nil ? attribute.content : user.statusMessage!
        case .phoneNumber:
            textField.text = user.phoneNumber == nil ? attribute.content : user.phoneNumber!
        default: fatalError()
        }
    }
    
    fileprivate func updatedLetterCount(withContent content: String, limitFromAttribute attribute: SettingAttribute)-> String {
        var letterCount: Int!
        switch attribute.contentType {
        case .name:
            letterCount = user.name.count
        case .status:
            letterCount = user.statusMessage != nil ? user.statusMessage!.count: attribute.content!.count
        case .phoneNumber:
            letterCount = user.phoneNumber != nil ? user.phoneNumber!.count: attribute.content!.count
        default: fatalError()
        }
        
        let maxCount = attribute.maximumLimit!
        textLimitLabel.textColor = letterCount <= maxCount ? .black : .red
        return "\(letterCount!)/\(maxCount)"
    }
}

extension EditSettingDetailViewController: DefaultViewController {
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        setupUI()
        attribute = SettingAttribute.unwrapFrom(userInfo: userInfo!)
        configure(withUser: AppStatus.current.user, withAttribute: attribute)
    }
    
    fileprivate func setupUI() {
        let backgroundView = UIView.create(withColor: .groupTableViewBackground)
        
        textLimitLabel = UILabel.create(text: "10/55", textAlignment: .right, textColor: .black, fontSize: 13, numberofLine: 1)
        descriptionLabel = UILabel.create(text: "Change your text", textAlignment: .left, textColor: .black, fontSize: 13, numberofLine: 1)
        
        saveButton = UIButton.create(title: "Save", titleColor: .white, fontSize: 15, backgroundColor: .mainBlue)
        saveButton.setCornerRadious(value: 5)
        
        let textFieldBackgroundView = UIView.create(withColor: .white)
        textField = UITextField.create(placeHolder: "Please enter your input", textSize: 15, textColor: .black, keyboardType: .default)
        textField.borderStyle = .none
        
        let group:[UIView] = [backgroundView, textLimitLabel, descriptionLabel,textFieldBackgroundView, saveButton]
        
        group.forEach(view.addSubview(_:))
        
        textFieldBackgroundView.addSubview(textField)
        
        backgroundView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(getHeightOfNavigationBarAndStatusBar()+20)
            make.left.equalToSuperview().offset(5)
        }
        
        textLimitLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel)
            make.right.equalToSuperview().offset(-5)
        }
        
        textFieldBackgroundView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.height.equalTo(80)
        }
        
        textField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldBackgroundView.snp.bottom).offset(25)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
    }
}







