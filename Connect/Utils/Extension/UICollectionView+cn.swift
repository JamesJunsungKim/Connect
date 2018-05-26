//
//  UICollectionView+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/26/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    internal func setup<A:ReusableCollectionViewCell>(withCell cell: A, delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        register(cell.classForCoder, forCellWithReuseIdentifier: A.reuseIdentifier)
        set(delegate: delegate, datasource: dataSource)
    }
    
    // MARK: - Fileprivate
    fileprivate func set(delegate: UICollectionViewDelegate, datasource: UICollectionViewDataSource) {
        self.dataSource = datasource
        self.delegate = delegate
    }
}
