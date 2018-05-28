//
//  Reusable.swift
//  Connect
//
//  Created by James Kim on 5/23/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

protocol Reusable:AnyObject {
    associatedtype Object = Self
}

typealias ReusableTableViewCell = Reusable & UITableViewCell
typealias ReusableCollectionViewCell = Reusable & UICollectionViewCell

extension Reusable {
    static var reuseIdentifier: String {
        let className = String(describing: Self.self)
//        let className = NSStringFromClass(self).components(separatedBy: ".")[1]
        return className
    }
}

extension Reusable where Self: UITableViewCell {
    
    static func cell(fromTableView tableView: UITableView, atIndexPath indexPath: IndexPath, configuration:(Self)->()) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Self
        configuration(cell)
        return cell
    }
}
