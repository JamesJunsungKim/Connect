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
    
    init(tableView: UITableView, delegate: Delegate, objects: [Object]) {
        self.tableView = tableView; self.delegate = delegate
        self.arrayOfObjects = objects
        super.init()
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        delegate.configure(cell, for: arrayOfObjects[indexPath.row])
        return cell
    }
    
    
    // MARK: - Fileprivate
    
    fileprivate let tableView: UITableView
    fileprivate var arrayOfObjects : [Object]
    fileprivate weak var delegate: Delegate!
}
