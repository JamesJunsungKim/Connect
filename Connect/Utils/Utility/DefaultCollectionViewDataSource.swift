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
    
    init(collectionView: UICollectionView, parentViewController: UIViewController, initialData: [Object]?,userInfo:[String:Any]?, observeCell:((A)->())? = nil) {
        self.collectionView = collectionView
        self.parentViewController = parentViewController
        self.observeCell = observeCell
        self.userInfo = userInfo
        super.init()
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView.dataSource = self
        arrayOfObjects = initialData.unwrapOr(defaultValue: [Object]())
        collectionView.reloadData()
    }
    
    public func update(data: [Object]) {
        arrayOfObjects = data
        collectionView.reloadData()
    }
    
    public func append(data:[Object]) {
        arrayOfObjects.append(contentsOf: data)
        collectionView.reloadData()
    }
    
    public func selectedObject(atIndexPath indexPath: IndexPath) -> Object {
        return arrayOfObjects[indexPath.item]
    }
    
    // DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfObjects.count
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
    fileprivate var arrayOfObjects = [Object]()
}
