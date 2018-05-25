//
//  Reusable.swift
//  Connect
//
//  Created by James Kim on 5/23/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

protocol Reusable {}

extension Reusable {
    static var reuseIdentifier: String {
        let className = NSStringFromClass(self as! (AnyClass)).components(separatedBy: ".")[1]
        return className
    }
}

extension Reusable where Self: UITableViewCell {
    static func defaultSetup(withTableView tableView: UITableView, forViewController target: UIViewController) {
        register(withTableview: tableView)
        tableView.setupdelegateAndDataSource(target: target)
    }
    
    
    static func register(withTableview tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    static func cell(fromTableView tableView: UITableView, atIndexPath indexPath: IndexPath, configuration:(Self)->()) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Self
        configuration(cell)
        return cell
    }
}
