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

typealias CDBaseModel = NSManagedObject & FileUploadable & Managed & UidFetchable & NameDescribable & Unwrappable

typealias ReusableTableViewCell = Reusable & UITableViewCell
typealias ReusableCollectionViewCell = Reusable & UICollectionViewCell
typealias CoreDataReusableTableViewCell = CoredataReusable & UITableViewCell
typealias CoreDataReusableCollectionViewCell = CoredataReusable & UICollectionViewCell

typealias block = ()->()
typealias failure = (Error)->()


