//
//  ContactCell.swift
//  Connect
//
//  Created by James Kim on 5/22/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    // UI
    fileprivate var profileImageView :UIImageView!
    fileprivate var nameLabel: UILabel!
    
    static let reuseIdentifier = "ContactCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    public func configure(withUser user: User) {
        profileImageView.image = user.profilePhoto?.image
        nameLabel.text = user.name
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactCell {
    fileprivate func setupUI() {
        
        profileImageView = UIImageView.create(withImageName: UIImageView.Keys.placeholder)
        nameLabel = UILabel.create(text: "Name", textAlignment: .left, textColor: .black, fontSize: 15, numberofLine: 1)
        
        let group :[UIView] = [profileImageView, nameLabel]
        
        group.forEach(addSubview(_:))
        
        profileImageView.snp.makeConstraints { (make) in
            profileImageView.setCornerRadious(value: 25)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(20)
        }
        
    }
}












