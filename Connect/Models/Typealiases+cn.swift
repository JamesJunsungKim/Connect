//
//  BaseModel.swift
//  Connect
//
//  Created by James Kim on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import CoreData
import FirebaseDatabase
import SwiftyJSON

// ViewController
typealias DefaultViewController = UIViewController & NameDescribable

// CoreData
typealias CDBaseModel = NSManagedObject & FileUploadable & Managed & UidFetchable & NameDescribable & Unwrappable


// TableView & CollectionView
typealias ReusableTableViewCell = Reusable & UITableViewCell
typealias ReusableCollectionViewCell = Reusable & UICollectionViewCell
typealias CoreDataReusableTableViewCell = CoredataReusable & UITableViewCell
typealias CoreDataReusableCollectionViewCell = CoredataReusable & UICollectionViewCell

// Handlers
typealias block = ()->()
typealias failure = (Error)->()


