//
//  UITableView+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/25/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UITableView {
    
    internal func setup<A:ReusableTableViewCell>(withCell cell: A, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        register(cell.classForCoder, forCellReuseIdentifier: A.reuseIdentifier)
        set(delegate: delegate, datasource: dataSource)
    }
    
    internal func setup<A:ReusableTableViewCell>(additionalCell cell:A) {
        register(cell.classForCoder, forCellReuseIdentifier: A.reuseIdentifier)
    }
    
    
    // MARK: - Fileprivate
    fileprivate func set(delegate: UITableViewDelegate, datasource: UITableViewDataSource) {
        self.dataSource = datasource
        self.delegate = delegate
    }
}
