//
//  AlbumDetailCell.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class AlbumDetailCell: ReusableTableViewCell {
    typealias Object = AlbumInfo
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        
    }
}
