//
//  UICollectionView+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/26/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: - Public/Internal
    internal func setup<A:ReusableCollectionViewCell>(withCell cell: A, delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        register(cell.classForCoder, forCellWithReuseIdentifier: A.reuseIdentifier)
        set(delegate: delegate, datasource: dataSource)
    }
    
    public func indexPathsForElements(in rect: CGRect) ->[IndexPath] {
        let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect)!
        return allLayoutAttributes.map{$0.indexPath}
    }
    
    // MARK: - Static
    static func create(backgroundColor: UIColor = .white, configuration: ((UICollectionViewFlowLayout)->())? = nil)-> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        configuration?(layout)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = backgroundColor
        return c
    }
    
    // MARK: - Fileprivate
    fileprivate func set(delegate: UICollectionViewDelegate, datasource: UICollectionViewDataSource) {
        self.dataSource = datasource
        self.delegate = delegate
    }
}
