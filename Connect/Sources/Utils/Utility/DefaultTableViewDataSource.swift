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
    typealias Section = Int
    
    init(tableView: UITableView, parentViewController: UIViewController, initialData: [Section:[Object]]? = nil, userInfo: [String:Any]? = nil, observableCell: ((A)->())? = nil) {
        self.tableView = tableView
        self.parentViewController = parentViewController
        self.userInfo = userInfo
        self.observe = observableCell
        super.init()
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        objectDictionary = initialData.unwrapOr(defaultValue: [Int:[Object]]())
        tableView.reloadData()
    }
    
    public var currentData: [Section:[Object]] {
        return objectDictionary
    }
    
    public func update(data: [Section:[Object]]) {
        objectDictionary = data
        tableView.reloadData()
    }
    
    public func update(data:[Section:[Object]], atSection section: Section) {
        validate(section: section)
        objectDictionary[section]! = data[section]!
        let indexSet = IndexSet.init(integer: section)
        tableView.reloadSections(indexSet, with: .automatic)
    }
    
    public func append(data:[Object], atSection section: Section) {
        validate(section: section)
        objectDictionary[section]!.append(contentsOf: data)
        let indexSet = IndexSet.init(integer: section)
        tableView.reloadSections(indexSet, with: .automatic)
    }
    
    public func object(atIndexPath indexPath: IndexPath) -> Object {
        validate(indexPath: indexPath)
        return objectDictionary[indexPath.section]![indexPath.row]
    }
    
    
    
    // DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectDictionary.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Section) -> Int {
        validate(section: section)
        return objectDictionary[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        cell.setup(withObject: object(atIndexPath: indexPath), parentViewController: parentViewController, currentIndexPath: indexPath, userInfo: userInfo)
        observe?(cell)
        return cell
    }
    
    // MARK: - Fileprivate
    
    fileprivate weak var parentViewController: UIViewController!
    fileprivate let tableView: UITableView
    fileprivate var objectDictionary = [Section:[Object]]()
    fileprivate let observe: ((A)->())?
    fileprivate let userInfo: [String:Any]?
    
    fileprivate func validate(indexPath: IndexPath) {
        validate(section: indexPath.section, row: indexPath.row)
    }
    
    fileprivate func validate(section: Int, row: Int? = nil) {
        guard section < objectDictionary.keys.count else {fatalError()}
        if row != nil {guard row! < objectDictionary[section]!.count else {fatalError()}}
    }
}





