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
typealias DefaultViewController = UIViewController & NameDescribable & DefaultSegue
typealias PopOverViewController = UIViewController & NameDescribable & PopOverable
typealias FormSheetViewController = UIViewController & NameDescribable & FormSheetable


// Model
typealias CDBaseModel = NSManagedObject & FileUploadable & Managed & UidFetchable & NameDescribable & Unwrappable & DictionaryCreatable
typealias BaseModel = NameDescribable & Unwrappable & DictionaryCreatable

// TableView & CollectionView
typealias ReusableTableViewCell = Reusable & UITableViewCell
typealias ReusableCollectionViewCell = Reusable & UICollectionViewCell
typealias CoreDataReusableTableViewCell = CoredataReusable & UITableViewCell
typealias CoreDataReusableCollectionViewCell = CoredataReusable & UICollectionViewCell

// Handlers
typealias block = ()->()
typealias failure = (Error)->()


