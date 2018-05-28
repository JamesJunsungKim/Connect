//
//  CollectionViewDataSource.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/28/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

protocol CollectionViewDataSourceDelegate:AnyObject {
    associatedtype Object
    associatedtype Cell: ReusableCollectionViewCell
    func configure(_ cell: Cell, for object: Object)
}
