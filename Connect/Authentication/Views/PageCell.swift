//
//  PageCell.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class PageCell: ReusableCollectionViewCell {
    
    typealias Object = Page

    
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
    
    func configure(withObject object: Page, parentViewController: UIViewController, currentIndexPath: IndexPath, userInfo: [String : Any]?) {
        imageView.image = UIImage(named: object.imageName)
        titleLabel.text = object.title
        descriptionLabel.text = object.description
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
            lb.font = UIFont.boldSystemFont(ofSize: 20)
            lb.textAlignment = .center
            return lb
        }()
        
        
        descriptionLabel = {
            let lb = UILabel()
            lb.textAlignment = .center
            lb.numberOfLines = 0
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
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.bounds.height*5/7)
        }
        
        separatorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(separatorLineView.snp.bottom)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().offset(5)
            make.bottom.equalToSuperview()
        }
        
        
    }
}












