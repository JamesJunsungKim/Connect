//
//  AlbumDetailCell.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class AlbumDetailCell: ReusableCollectionViewCell {
    typealias Object = AlbumInfo
    
    // UI
    fileprivate var albumImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
   
    func configure(withObject object: AlbumInfo, parentViewController: UIViewController, currentIndexPath: IndexPath, userInfo: [String : Any]?) {

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumDetailCell {
    fileprivate func setupUI(){
        albumImageView = UIImageView.create()
        addSubview(albumImageView)
        albumImageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}
