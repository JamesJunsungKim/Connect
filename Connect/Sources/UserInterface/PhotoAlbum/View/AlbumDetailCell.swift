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
    public var albumImageView: UIImageView!
    fileprivate var checkImage: UIImageView!
    fileprivate var whiteFilterView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func prepareForReuse() {
        albumImageView.image = nil
        representedAssetIdentifier = nil
        hideOrShowFilterAndCheckImage(needToShow: false)
    }
    
    // MAKR: - Public
    public var representedAssetIdentifier: String!
    

    
    public func didGetSelected() {
        hideOrShowFilterAndCheckImage(needToShow: true)
    }
    
    public func didGetDeselected() {
        hideOrShowFilterAndCheckImage(needToShow: false)
    }
    
    fileprivate func hideOrShowFilterAndCheckImage(needToShow: Bool) {
        let group:[UIView] = [whiteFilterView, checkImage]
        group.forEach({$0.isHidden = !needToShow})
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumDetailCell {
    fileprivate func setupUI(){
        albumImageView = UIImageView.create()
        albumImageView.contentMode = .scaleAspectFill
        
        whiteFilterView = UIView.create(withColor: .white, alpha: 0.3)
        whiteFilterView.isHidden = true
        
        checkImage = UIImageView.create(withImageKey: .thichCheck)
        checkImage.isHidden = true

        
        let group: [UIView] = [albumImageView, whiteFilterView, checkImage]
        group.forEach(addSubview(_:))
        
        albumImageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        whiteFilterView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(albumImageView)
        }
        
        checkImage.snp.makeConstraints { (make) in
            make.topRightqualToSuperView(withOffset: 10)
            make.sizeEqualTo(width: 20, height: 20)
        }
    }
}
