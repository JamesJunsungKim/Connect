//
//  DefaultTableViewDataSource.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/26/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

protocol TableViewDataSourceDelegate: class {
    associatedtype Object
    associatedtype Cell: ReusableTableViewCell
    func configure(_ cell: Cell, for object: Object)
    var numberOfAdditionalRows: Int { get }
    func supplementaryObject(at indexPath: IndexPath) -> Object?
    func presentedIndexPath(for fetchedIndexPath: IndexPath) -> IndexPath
    func fetchedIndexPath(for presentedIndexPath: IndexPath) -> IndexPath?
}

extension TableViewDataSourceDelegate {
    var numberOfAdditionalRows: Int {
        return 0
    }
    
    func supplementaryObject(at indexPath: IndexPath) -> Object? {
        return nil
    }
    
    func presentedIndexPath(for fetchedIndexPath: IndexPath) -> IndexPath {
        return fetchedIndexPath
    }
    
    func fetchedIndexPath(for presentedIndexPath: IndexPath) -> IndexPath? {
        return presentedIndexPath
    }
}
