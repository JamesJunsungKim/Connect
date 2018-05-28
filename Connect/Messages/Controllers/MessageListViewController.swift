//
//  MessageViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import CoreData

class MessageListViewController: UIViewController {
    // UI
    
    fileprivate var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVC()
        setupTableView()
    }
    
    // MARK: - Actions
    
    @objc fileprivate func plusBtnClicked() {
        
    }
    
    fileprivate func tableViewCellSelected(atIndexPath indexPath: IndexPath) {
        
    }
    
    // MARK: - Filepriavte
    fileprivate weak var dataSource: CoreDataTableViewDataSource<Message,MessageListViewController>!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Message"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus_icon"), style: .plain, target: self, action: #selector(plusBtnClicked))
    }
    
    fileprivate func setupTableView(){
        tableview.delegate = self
        
        let request = Message.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 12
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: mainContext, sectionNameKeyPath: nil, cacheName: nil)
        
        dataSource = CoreDataTableViewDataSource(tableView: tableview, fetchedResultsController: frc, dataSource: self)
        
    }
    
    
}
extension MessageListViewController: TableViewDataSourceDelegate, UITableViewDelegate {
    typealias Object = Dummy
    typealias Cell = MessageListCell
    
    func configure(_ cell: MessageListCell, for object: Dummy) {
        cell.backgroundColor = .red
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewCellSelected(atIndexPath: indexPath)
    }
}

extension MessageListViewController {
    fileprivate func setupUI() {
        tableview = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
