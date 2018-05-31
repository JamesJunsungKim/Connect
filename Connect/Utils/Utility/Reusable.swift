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

protocol Reusable:AnyObject, NameDescribable {
    associatedtype Object
    func setup(withObject object: Object, parentViewController: UIViewController, currentIndexPath: IndexPath)
    func update(withObject oject: Object, atIndexPath indexPath: IndexPath)
}

extension Reusable {
    static var reuseIdentifier: String {
        return Self.staticClassName
    }
    func update(withObject oject: Object, atIndexPath indexPath: IndexPath){}
}

protocol CoredataReusable:AnyObject, NameDescribable {
    associatedtype Object:NSFetchRequestResult
    func setup(withObject object: Object, parentViewController: UIViewController, currentIndexPath: IndexPath)
    func update(withObject oject: Object, atIndexPath indexPath: IndexPath)
}

extension CoredataReusable {
    static var reuseIdentifier: String {
        return Self.staticClassName
    }
    
    func update(withObject oject: Object, atIndexPath indexPath: IndexPath){}
}
