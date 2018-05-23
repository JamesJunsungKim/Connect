//
//  SettingCell.swift
//  Connect
//
//  Created by James Kim on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class SettingCell: UITableViewCell, Reusable {
    
    // UI
    fileprivate var settingImageView: UIImageView!
    fileprivate var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    public func configure(withSetting setting: Setting) {
        settingImageView.image = UIImage(named: setting.imageName)!
        titleLabel.text = setting.title
    }
    
    
    fileprivate func setupUI() {
        settingImageView = UIImageView.create(withImage: UIImage())
        
        titleLabel = UILabel.create(text: "Title", textAlignment: .left, textColor: .black, fontSize: 17, numberofLine: 1)
        
        let rightArrowImageView = UIImageView.create(withImageName: "right_arrow")
        let group : [UIView] = [settingImageView, titleLabel, rightArrowImageView]
        group.forEach(self.addSubview(_:))
        
        settingImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(25)
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(settingImageView.snp.right).offset(25)
        }
        
        rightArrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 24))
            make.right.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
