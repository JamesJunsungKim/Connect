//
//  MessageCell.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/25/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class MessageListCell: ReusableTableViewCell {
    // UI
    
    fileprivate var profileImageView: UIImageView!
    fileprivate var nameLabel: UILabel!
    fileprivate var messageLabel: UILabel!
    fileprivate var sentDateLabel: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    // MARK: - Public
    
    public func configure(withMessage: Message) {
        
    }
    
    // MARK: - Actions
    
    // MARK: - Fileprivate
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessageListCell {
    fileprivate func setupUI() {
        profileImageView = UIImageView.create(withImageKey: .placeholder)
        
        nameLabel = UILabel.create(text: "James", textAlignment: .left, textColor: .black, fontSize: 17, boldFont: true, numberofLine: 1)
        
        messageLabel = UILabel.create(text: "Messages will be shown up here and it can be 2-lines long", textAlignment: .left, textColor: .lightBackgroundGray, fontSize: 12, boldFont: false, numberofLine: 0)
        
        sentDateLabel = UILabel.create(text: "12:00 PM", textAlignment: .right, textColor: .lightBackgroundGray, fontSize: 11, boldFont: false, numberofLine: 1)
        
        let separatorLine = UIView.create()
        
        
        let group: [UIView] = [profileImageView, nameLabel, messageLabel, sentDateLabel]
        
        group.forEach(self.addSubview(_:))
        
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7.5)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-7.5)
            make.width.equalTo(profileImageView.frame.height)
            profileImageView.setCornerRadious(value: profileImageView.frame.height*1/2)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.right.equalTo(sentDateLabel.snp.left).offset(-5)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalTo(profileImageView)
        }
        
        sentDateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameLabel)
            make.right.equalToSuperview().offset(5)
        }
        
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp.bottom)
            make.leading.equalTo(nameLabel)
            make.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}







