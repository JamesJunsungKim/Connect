//
//  PageCell.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    public static let cellId = "pageCell"
    
    // UI
    fileprivate var imageView: UIImageView!
    fileprivate var titleLabel: UILabel!
    fileprivate var descriptionLabel: UILabel!
    fileprivate var separatorLineView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(withPage page: Page) {
        imageView.image = UIImage(named: page.imageName)
        titleLabel.text = page.title
        descriptionLabel.text = page.description
    }
    
    
}

//MARK: - Setup UI
extension PageCell {
    fileprivate func setupUI() {
        
        imageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            return iv
        }()
        
        titleLabel = {
            let lb = UILabel()
            lb.font = UIFont.boldSystemFont(ofSize: 15)
            lb.textAlignment = .center
            return lb
        }()
        
        
        descriptionLabel = {
            let lb = UILabel()
            lb.textAlignment = .center
            return lb
        }()
        
        separatorLineView = {
            let v = UIView()
            v.backgroundColor = .lightGray
            return v
        }()
        
        let group: [UIView] = [imageView, titleLabel, descriptionLabel, separatorLineView]
        group.forEach(self.addSubview(_:))
        
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(self.bounds.height*5/7)
        }
        
        separatorLineView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(imageView)
            make.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(separatorLineView).offset(5)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel).offset(10)
        }
        
        
    }
}












