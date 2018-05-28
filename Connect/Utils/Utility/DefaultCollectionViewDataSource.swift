//
//  DefaultCollectionViewDataSource.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/28/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class DefaultCollectionViewDataSource<Delegate:CollectionViewDataSourceDelegate>:NSObject, UICollectionViewDataSource {
    
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    
    init(collectionView: UICollectionView, sourceDelegate: Delegate, initialData: [Object]?) {
        self.collectionView = collectionView
        self.sourceDelegate = sourceDelegate
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
        sourceDelegate.configure(cell, for: arrayOfObjects[indexPath.item])
        return cell
    }
    
    
    // MARK: - Fileprivate
    fileprivate let collectionView: UICollectionView
    fileprivate var arrayOfObjects = [Object]()
    fileprivate weak var sourceDelegate: Delegate!
}
