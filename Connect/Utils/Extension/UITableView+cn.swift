//
//  UITableView+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/25/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UITableView {
    internal func setupdelegateAndDataSource(target: UIViewController) {
        dataSource = target as? UITableViewDataSource
        delegate = target as? UITableViewDelegate
    }
}
