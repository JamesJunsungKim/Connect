//
//  CoreDataTableViewDataSource.swift
//  Connect
//
//  Created by James Kim on 5/27/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableViewDataSource<A:CoreDataReusableTableViewCell>:NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    typealias Object = A.Object
    typealias Cell = A
    
    required init(tableView:UITableView, fetchedResultsController:NSFetchedResultsController<Object>, parentViewController: UIViewController, observableCell: ((A)->())? = nil) {
        self.tableView = tableView
        self.fetchedResultsController = fetchedResultsController
        self.parentViewController = parentViewController
        if observableCell != nil {self.observe = observableCell!}
        super.init()
        fetchedResultsController.delegate = self
        try! fetchedResultsController.performFetch()
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.reloadData()
    }
    
    public var selectedObject: Object? {
        guard let indexPath = tableView.indexPathForSelectedRow else {return nil}
        return objectAtIndexPath(indexPath)
    }
    
    public func objectAtIndexPath(_ indexPath: IndexPath) -> Object {
        return fetchedResultsController.object(at: indexPath)
        
    }
    
    public func reconfigureFetchRequest(_ configure: (NSFetchRequest<Object>) -> ()) {
        NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: fetchedResultsController.cacheName)
        configure(fetchedResultsController.fetchRequest)
        do { try fetchedResultsController.performFetch() } catch { fatalError("fetch request failed") }
        tableView.reloadData()
    }
    
    // MARK: - Filepriavte
    fileprivate let tableView: UITableView
    fileprivate let fetchedResultsController: NSFetchedResultsController<Object>
    fileprivate weak var parentViewController: UIViewController!
    fileprivate var observe: ((A)->())!
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else {return 0}
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {return 0}
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {fatalError()}
        cell.setup(withObject: objectAtIndexPath(indexPath), parentViewController: parentViewController, currentIndexPath: indexPath)
        if observe != nil {observe(cell)}
        return cell
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { fatalError("Index path should be not nil") }
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            let object = objectAtIndexPath(indexPath)
            guard let cell = tableView.cellForRow(at: indexPath) as? Cell else { break }
            cell.update(withObject: object, atIndexPath: indexPath)
        case .delete:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        default: break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let targetIndex = IndexSet(integer:sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(targetIndex, with: .automatic)
        case .delete:
            tableView.deleteSections(targetIndex, with: .automatic)
        default: break;
        }
    }
}
