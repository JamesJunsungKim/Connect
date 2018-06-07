//
//  AlbumDetailCell.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import Photos

class AlbumDetailCell: ReusableCollectionViewCell {
    
    typealias Object = AlbumDetailInfo
    
    // UI
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func configure(withObject object: AlbumDetailInfo, parentViewController: UIViewController, currentIndexPath: IndexPath, userInfo: [String : Any]?) {/*no-op*/}
    
    public var albumImageView: UIImageView!
    public var representedAssetIdentifier: String!
    
    override func prepareForReuse() {
        albumImageView.image = nil
        representedAssetIdentifier = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumDetailCell {
    fileprivate func setupUI(){
        albumImageView = UIImageView.create()
        albumImageView.contentMode = .scaleAspectFill
        addSubview(albumImageView)
        albumImageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}
