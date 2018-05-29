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
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
        setupTableView()
    }
    
    deinit {
        leaveViewControllerMomeryLogAndSaveDataToDisk(type: self.classForCoder)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func plusBtnClicked() {
        
    }
    
    fileprivate func didSelectTableViewCell(atIndexPath indexPath: IndexPath) {
        
    }
    
    // MARK: - Filepriavte
    fileprivate var dataSource: CoreDataTableViewDataSource<Message,MessageListViewController>!
    fileprivate var dataSource__: DefaultTableViewDataSource<MessageListViewController>!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Message"
        navigationController?.setupVerticalInset()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage.create(forKey: .plusIcon), style: .plain, target: self, action: #selector(plusBtnClicked))
    }
    
    fileprivate func setupTableView(){
        tableview.delegate = self
        
        dataSource__ = DefaultTableViewDataSource.init(tableView: tableview, sourceDelegate: self, initialData: [Dummy(),Dummy(),Dummy(),Dummy(),Dummy(),Dummy()])
        
//        let request = Message.sortedFetchRequest
//        request.returnsObjectsAsFaults = false
//        request.fetchBatchSize = 12
//
//        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: mainContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        dataSource = CoreDataTableViewDataSource(tableView: tableview, fetchedResultsController: frc, dataSource: self)
        
    }
}
extension MessageListViewController: TableViewDataSourceDelegate, UITableViewDelegate {
    typealias Object = Dummy
    typealias Cell = MessageListCell
    
    func configure(_ cell: MessageListCell, for object: Dummy) {
        
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectTableViewCell(atIndexPath: indexPath)
    }
}

extension MessageListViewController {
    fileprivate func setupUI() {
        tableview = UITableView(frame: .zero, style: .plain)
        tableview.separatorStyle = .none
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
