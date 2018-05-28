//
//  DefaultTableViewDataSource.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/26/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class DefaultTableViewDataSource<Delegate:TableViewDataSourceDelegate>: NSObject, UITableViewDataSource {
    
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    
    init(tableView: UITableView, sourceDelegate: Delegate, initialData: [Object]? = nil) {
        self.tableView = tableView; self.sourceDelegate = sourceDelegate
        super.init()
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        arrayOfObjects = initialData.unwrapOr(defaultValue: [Object]())
        tableView.reloadData()
    }
    
    public func update(data: [Object]) {
        arrayOfObjects = data
        tableView.reloadData()
    }
    
    public func append(data:[Object]) {
        arrayOfObjects.append(contentsOf: data)
        tableView.reloadData()
    }
    
    public func selectedObject(atIndexPath indexPath: IndexPath) -> Object {
        return arrayOfObjects[indexPath.row]
    }
    
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        sourceDelegate.configure(cell, for: arrayOfObjects[indexPath.row])
        return cell
    }
    
    
    
    // MARK: - Fileprivate
    
    fileprivate let tableView: UITableView
    fileprivate var arrayOfObjects = [Object]()
    fileprivate weak var sourceDelegate: Delegate!
}





