//
//  ProfileCell.swift
//  Connect
//
//  Created by James Kim on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

class ProfileCell: ReusableTableViewCell {
    typealias Object = User
    
    // UI
    fileprivate var profileImageView: UIImageView!
    fileprivate var nameLabel: UILabel!
    fileprivate var statusLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(withObject object: User, parentViewController: UIViewController, currentIndexPath: IndexPath, userInfo: [String : Any]?) {
        profileImageView.image = object.profilePhoto!.image
        nameLabel.text = object.name
        statusLabel.text = object.statusMessage.unwrapOr(defaultValue: "Your status message will be displayed here.")
    }
    
    public func configure(withUser user: User) {
        profileImageView.image = user.profilePhoto!.image
        nameLabel.text = user.name
        statusLabel.text = user.statusMessage.unwrapOr(defaultValue: "Your status message will be displayed here.")
    }
   
    
    fileprivate func setupUI() {
        profileImageView = UIImageView.create(withImage: UIImage(), contentMode: .scaleAspectFill)
        profileImageView.setCornerRadious(value: 30)
        nameLabel = UILabel.create(text: "Name", textAlignment: .left, textColor: .black, fontSize: 20, numberofLine: 1)
        statusLabel = UILabel.create(text: "Your status message will be displayed here", textAlignment: .left, textColor: .black, fontSize: 14, numberofLine: 1)
        
        let group: [UIView] = [profileImageView, nameLabel, statusLabel]
        group.forEach(self.addSubview(_:))
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(20)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(profileImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
