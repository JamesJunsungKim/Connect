//
//  MessageViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import CoreData

class MessageListViewController: DefaultViewController {
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
        leaveViewControllerMomeryLogSaveData(type: self.classForCoder)
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
    fileprivate var dataSource: CoreDataTableViewDataSource<MessageListCell>!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Message"
        navigationController?.setupVerticalInset()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage.create(forKey: .plusIcon), style: .plain, target: self, action: #selector(plusBtnClicked))
    }
    
    fileprivate func setupTableView(){
        tableview.delegate = self
        
        let allUids = User.fetchAllUsers(fromMOC: appStatus.mainContext, excludingUID: appStatus.user.uid!).map({$0.uid!})
        let predicate = NSPredicate(format: "%K IN %@", #keyPath(Message.fromUser.uid), allUids)
        
        //TODO: How to fetch only one message for all of those.
        Message.fetch(in: appStatus.mainContext) { (request) in
            
        }
        let request = Message.sortedFetchRequest(with: predicate)
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 12

        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appStatus.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        dataSource = CoreDataTableViewDataSource<MessageListCell>.init(tableView: tableview, fetchedResultsController: frc, parentViewController: self)
        
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
