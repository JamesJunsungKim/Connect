//
//  MessageCell.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/25/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class MessageListCell: ReusableTableViewCell {
    typealias Object = Dummy
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
    public func setup(withObject object: Dummy, parentViewController: UIViewController, currentIndexPath: IndexPath) {
//        configure(withMessage: object)
    }
    
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
        profileImageView = UIImageView.create(withImageKey: .personPlaceHolder)
        
        nameLabel = UILabel.create(text: "James", textAlignment: .left, textColor: .black, fontSize: 17, boldFont: true, numberofLine: 1)
        
        messageLabel = UILabel.create(text: "Messages will be shown up here and it can be 2-lines long", textAlignment: .left, textColor: .gray, fontSize: 12, boldFont: false, numberofLine: 0)
        
        sentDateLabel = UILabel.create(text: "12:00 PM", textAlignment: .right, textColor: .gray, fontSize: 11, boldFont: false, numberofLine: 1)
        
        let separatorLine = UIView.create()
        
        
        let group: [UIView] = [profileImageView, nameLabel, messageLabel, sentDateLabel, separatorLine]
        
        group.forEach(self.addSubview(_:))
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.sizeEqualTo(width: 60, height: 60)
            profileImageView.setCornerRadious(value: 30)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView).offset(-5)
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
            make.right.equalToSuperview().offset(-15)
        }
        
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(0.5)
        }
    }
}







