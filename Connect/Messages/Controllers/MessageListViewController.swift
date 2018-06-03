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
    
    init(appStatus:AppStatus) {
        self.appStatus = appStatus
        super.init(nibName: nil, bundle: nil)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
        setupTableView()
    }
    
    deinit {
        leaveViewControllerMomeryLog(type: self.classForCoder)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func plusBtnClicked() {
        
    }
    
    fileprivate func didSelectTableViewCell(atIndexPath indexPath: IndexPath) {
        // TODO: get the target user from data source and pass it to the next view controller
        presentDefaultVC(targetVC: MessageDetailViewController(appStatus: appStatus), userInfo: nil)
        
    }
    
    // MARK: - Filepriavte
    fileprivate let appStatus: AppStatus
//    fileprivate var dataSource: CoreDataTableViewDataSource<Message,MessageListViewController>!
    fileprivate var dataSource__: DefaultTableViewDataSource<MessageListCell>!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Message"
        navigationController?.setupVerticalInset()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage.create(forKey: .plusIcon), style: .plain, target: self, action: #selector(plusBtnClicked))
    }
    
    fileprivate func setupTableView(){
        tableview.delegate = self
        
        dataSource__ = DefaultTableViewDataSource<MessageListCell>.init(tableView: tableview, parentViewController: self, initialData: [0:[Dummy(),Dummy(),Dummy(),Dummy(),Dummy(),Dummy()]], userInfo: nil, observableCell: nil)
//        let request = Message.sortedFetchRequest
//        request.returnsObjectsAsFaults = false
//        request.fetchBatchSize = 12
//
//        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: mainContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        dataSource = CoreDataTableViewDataSource(tableView: tableview, fetchedResultsController: frc, dataSource: self)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MessageListViewController: UITableViewDelegate {
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
