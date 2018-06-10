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
    
    fileprivate var whiteFilterView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // MAKR: - Public
    public var representedAssetIdentifier: String!
    

    
    public func didGetSelected() {
        whiteFilterView.isHidden = false
        
    }
    
    public func didGetDeselected() {
        whiteFilterView.isHidden = true
        
    }
    
    
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
        
        whiteFilterView = UIView.create(withColor: .white, alpha: 0.3)
        whiteFilterView.isHidden = true
        
        
        let group: [UIView] = [albumImageView, whiteFilterView]
        group.forEach(addSubview(_:))
        
        albumImageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        whiteFilterView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(albumImageView)
        }
        

    }
}
