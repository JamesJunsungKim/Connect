//
//  Reusable.swift
//  Connect
//
//  Created by James Kim on 5/23/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData

typealias ReusableTableViewCell = Reusable & UITableViewCell
typealias ReusableCollectionViewCell = Reusable & UICollectionViewCell
typealias CoreDataReusableTableViewCell = CoredataReusable & UITableViewCell
typealias CoreDataReusableCollectionViewCell = CoredataReusable & UICollectionViewCell

protocol Reusable:AnyObject {
    associatedtype Object
    func setup(withObject object: Object, parentViewController: UIViewController, currentIndexPath: IndexPath)
    func update(withObject oject: Object, atIndexPath indexPath: IndexPath)
}

extension Reusable {
    static var reuseIdentifier: String {
        let className = String(describing: self)
        return className
    }
    func update(withObject oject: Object, atIndexPath indexPath: IndexPath){}
}

protocol CoredataReusable:AnyObject {
    associatedtype Object:NSFetchRequestResult
    func setup(withObject object: Object, parentViewController: UIViewController, currentIndexPath: IndexPath)
    func update(withObject oject: Object, atIndexPath indexPath: IndexPath)
}

extension CoredataReusable {
    static var reuseIdentifier: String {
        let className = String(describing: self)
        return className
    }
    
    func update(withObject oject: Object, atIndexPath indexPath: IndexPath){}
}
