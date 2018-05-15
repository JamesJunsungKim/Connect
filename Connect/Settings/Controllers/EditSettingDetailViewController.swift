//
//  EditSettingDetailViewController.swift
//  Connect
//
//  Created by James Kim on 5/15/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

class EditSettingDetailViewController: UIViewController {
    
    // UI
    fileprivate var textField: UITextField!
    fileprivate var descriptionLabel: UILabel!
    fileprivate var textLimitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterMemoryLog(type: self.classForCoder)
        setupVC()
        addTarget()
    }
    deinit {
        leaveMomeryLog(type: self.classForCoder)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func textValueChanged() {
        let count = textField.text!.count
        
    }
    
    
    // MARK: - Fileprivate
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
    }
    
    fileprivate func addTarget() {
        textField.addTarget(self, action: #selector(textValueChanged), for: .editingChanged)
    }
    
    fileprivate func configure(withUser user: User) {
        
    }
}

extension EditSettingDetailViewController: DefaultViewController {
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        setupUI()
        configure(withUser: User.unwrapFrom(userInfo: userInfo!))
    }
    
    fileprivate func setupUI() {
        let backgroundView = UIView.create(withColor: .groupTableViewBackground)
        
        textLimitLabel = UILabel.create(text: "10/55", textAlignment: .right, textColor: .black, fontSize: 13, numberofLine: 1)
        descriptionLabel = UILabel.create(text: "Change your text", textAlignment: .left, textColor: .black, fontSize: 13, numberofLine: 1)
        
        let textFieldBackgroundView = UIView.create(withColor: .white)
        textField = UITextField.create(placeHolder: "HI", textSize: 15, color: .black, keyboardType: .default)
        textField.borderStyle = .none
        
        let group:[UIView] = [backgroundView, textLimitLabel, descriptionLabel,textFieldBackgroundView]
        
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
        
    }
}







