//
//  SettingAttributeCell.swift
//  Connect
//
//  Created by James Kim on 5/14/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import ARSLineProgress

class SettingAttributeCell: UITableViewCell, Reusable {
    
    // UI
    fileprivate var titleLabel: UILabel!
    fileprivate var contentLabel: UILabel!
    fileprivate var toggle: UISwitch!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addTarget()
    }
    
    // MARK: - Public
    public func configure(withAttribute attribute: SettingAttribute, withUser user: User) {
        // UI
        self.attribute = attribute
        self.user = user
        
        switch attribute.type {
        case .label:
            contentLabel.text = attribute.content
            toggle.isHidden = true
        case .toggle:
            contentLabel.isHidden = true
        case .onlyAction:
            toggle.isHidden = true
            contentLabel.isHidden = true
            titleLabel.textColor = .red
            titleLabel.snp.remakeConstraints { (make) in
                make.centerX.centerY.equalToSuperview()
            }
        }
        titleLabel.text = attribute.title
        
        // update UI with data
        switch attribute.contentType {
        case .name: break /*no-op*/
        case .status:
            contentLabel.text = user.unwrapStatusMessageOrDefault()
        case .email:
            contentLabel.text = user.emailAddress
        case .phoneNumber:
            contentLabel.text = user.phoneNumber.unwrapOr(defaultValue: "Enter your phone number")
        case .isAccountPrivate:
            toggle.isOn = user.isPrivate
        case .auctionNotRequired: break /*no-op*/
            
        }
    }
    
    // MARK: - Actions
    fileprivate func addTarget() {
        toggle.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
    }
    
    
    // MARK: - Fileprivate
    fileprivate var attribute: SettingAttribute!
    fileprivate weak var user: User!
    
    @objc fileprivate func switchValueChange() {
        guard attribute.type == .toggle else {return}
        switch attribute.contentType {
        case .isAccountPrivate:
            ARSLineProgress.ars_showOnView(self)
            user.privateSwitchToggled(success: {
                ARSLineProgress.hide()
            }) { (error) in
                self.getParentViewController()?.presentDefaultError(message: error.localizedDescription, okAction: nil)
            }
        default: fatalError()
        }
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingAttributeCell {
    fileprivate func setupUI(){
        titleLabel = UILabel.create(text: "title", textAlignment: .left, textColor: .black, fontSize: 15, numberofLine: 1)
        
        contentLabel = UILabel.create(text: "content", textAlignment: .left, textColor: .black, fontSize: 13, numberofLine: 1)
        
        toggle = UISwitch()
        toggle.onTintColor = .mainBlue
        
        let group: [UIView] = [titleLabel, contentLabel, toggle]
        group.forEach(self.addSubview(_:))
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        
        toggle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 30))
            make.right.equalToSuperview().offset(-5)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.center.x)
            make.right.equalToSuperview().offset(-5)
        }
        
    }
}





