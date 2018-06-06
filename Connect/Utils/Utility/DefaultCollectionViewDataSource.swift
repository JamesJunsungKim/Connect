//
//  DefaultCollectionViewDataSource.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/28/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class DefaultCollectionViewDataSource<A:ReusableCollectionViewCell>:NSObject, UICollectionViewDataSource {
    
    typealias Object = A.Object
    typealias Cell = A
    typealias Section = Int
    
    init(collectionView: UICollectionView, parentViewController: UIViewController, initialData: [Section:Object]? = nil, userInfo:[String:Any]? = nil, observeCell:((A)->())? = nil) {
        self.collectionView = collectionView
        self.parentViewController = parentViewController
        self.observeCell = observeCell
        self.userInfo = userInfo
        super.init()
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView.dataSource = self
        objectDictionary = initialData.unwrapOr(defaultValue: [Section:[Object]]())
        collectionView.reloadData()
    }
    
    public func update(dictionary: [Int:[Object]]) {
        objectDictionary = dictionary
        collectionView.reloadData()
    }
    
    public func update(list:[Object], atSection section:Section) {
        validate(section: section)
        objectDictionary[section] = list
        let indexSet = IndexSet.init(integer: section)
        collectionView.reloadSections(indexSet)
    }
    
    public func append(list:[Object], atSection section: Section) {
        validate(section: section)
        objectDictionary[section]!.append(contentsOf: list)
        let indexSet = IndexSet.init(integer: section)
        collectionView.reloadSections(indexSet)
    }
    
    public func selectedObject(atIndexPath indexPath: IndexPath) -> Object {
        return objectDictionary[indexPath.section]![indexPath.item]
    }
    
    // DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return objectDictionary.keys.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectDictionary[section]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        cell.configure(withObject: selectedObject(atIndexPath: indexPath), parentViewController: parentViewController, currentIndexPath: indexPath, userInfo: userInfo)
        observeCell?(cell)
        return cell
    }
    
    
    // MARK: - Fileprivate
    fileprivate weak var parentViewController: UIViewController!
    fileprivate let collectionView: UICollectionView
    fileprivate let observeCell: ((A)->())?
    fileprivate let userInfo: [String:Any]?
    fileprivate var objectDictionary = [Section:[Object]]()
    
    fileprivate func validate(indexPath: IndexPath) {
        validate(section: indexPath.section, item: indexPath.item)
    }
    
    fileprivate func validate(section: Int, item: Int? = nil) {
        guard section < objectDictionary.keys.count else {fatalError()}
        if item != nil {guard item! < objectDictionary[section]!.count else {fatalError()}}
    }
}
