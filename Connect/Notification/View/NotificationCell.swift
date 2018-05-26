//
//  NotificationCell.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/26/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class NotificationCell: ReusableTableViewCell {
    // UI
    fileprivate var profileImageView: UIImageView!
    fileprivate var descriptionLabel: UILabel!
    fileprivate var actionButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    public func configure() {
        
    }
    
    // MARK: - Actions
    @objc fileprivate func buttonClicked() {
        
    }
    
    
    // MARK: - Fileprivate
    fileprivate func addTarget() {
        actionButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
}


extension NotificationCell {
    fileprivate func setupUI() {
        profileImageView = UIImageView.create(withImageKey: .placeholder)
        
        descriptionLabel = UILabel.create(text: "Someone sent you a friend request", textAlignment: .left, textColor: .black, fontSize: 12, numberofLine: 0)
        
        actionButton = UIButton.create(title: "Action", titleColor: .white, fontSize: 14, backgroundColor: .mainBlue)
        
        let group: [UIView] = [profileImageView, descriptionLabel, actionButton]
        group.forEach(self.addSubview(_:))
        
        let height = bounds.height
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: height*5/6, height: height*5/6))
            make.left.equalToSuperview().offset(10)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(5)
            make.right.equalTo(actionButton.snp.left).offset(-5)
        }
        
        actionButton.snp.makeConstraints { (make) in
            actionButton.setCornerRadious(value: 5)
            make.centerY.equalTo(profileImageView)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 90, height: 30))
        }
        
        
        
        
        
        
        
        
        
    }
}
