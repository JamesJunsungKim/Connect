//
//  DefaultTableViewDataSource.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/26/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class DefaultTableViewDataSource<A:ReusableTableViewCell>: NSObject, UITableViewDataSource {
    
    typealias Object = A.Object
    typealias Cell = A
    
    init(tableView: UITableView, parentViewController: UIViewController, initialData: [Object]? = nil, observableCell: ((A)->())? = nil) {
        self.tableView = tableView
        self.parentViewController = parentViewController
        if observableCell != nil {self.observe = observableCell!}
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
        cell.setup(withObject: selectedObject(atIndexPath: indexPath), parentViewController: parentViewController, currentIndexPath: indexPath)
        if observe != nil {observe(cell)}
        return cell
    }
    
    
    
    // MARK: - Fileprivate
    
    fileprivate let tableView: UITableView
    fileprivate var arrayOfObjects = [Object]()
    fileprivate weak var parentViewController: UIViewController!
    fileprivate var observe: ((A)->())!
}





