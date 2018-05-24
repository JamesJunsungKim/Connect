//
//  ContactCell.swift
//  Connect
//
//  Created by James Kim on 5/22/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SDWebImage

class ContactCell: UITableViewCell, Reusable {
    
    // UI
    fileprivate var profileImageView :UIImageView!
    fileprivate var nameLabel: UILabel!
    fileprivate var statusLabel: UILabel!
    fileprivate var checkImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    public func configure(withUser user: User) {
        profileImageView.image = user.profilePhoto?.image
        nameLabel.text = user.name
    }
    
    public func configure(withNonCDUser user: NonCDUser) {
        nameLabel.text = user.name
        profileImageView.sd_setImage(with: user.profilePhoto!.url.convertToURL(), completed: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactCell {
    fileprivate func setupUI() {
        
        profileImageView = UIImageView.create(withImageKey: .placeholder)
        nameLabel = UILabel.create(text: "Name", textAlignment: .left, textColor: .black, fontSize: 15, numberofLine: 1)
        statusLabel = UILabel.create(text: "Status", textAlignment: .left, textColor: .lightGray, fontSize: 10, numberofLine: 1)
        checkImageView = UIImageView.create(withImageKey: .uncheked)
        
        let stackview = UIStackView.create(views: [nameLabel, statusLabel], axis: .vertical, alignment: .fill, distribution: .equalSpacing, spacing: 5)
        
        let group :[UIView] = [profileImageView, stackview, checkImageView]
        
        group.forEach(addSubview(_:))
        
        profileImageView.snp.makeConstraints { (make) in
            profileImageView.setCornerRadious(value: 25)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        checkImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        stackview.snp.makeConstraints { (make) in
            make.left.equalTo(profileImageView.snp.right).offset(5)
            make.right.equalTo(checkImageView.snp.left).offset(-5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
    }
}












