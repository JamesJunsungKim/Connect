//
//  NotificationViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit
import RxSwift
import CoreData

class NotificationViewController: UIViewController {

    // UI
    
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
        setupObserver()
        setupTableView()
    }
    
    deinit {
        leaveViewControllerMomeryLogAndSaveDataToDisk(type: self.classForCoder)
    }

    // MARK: - Public
    
    // MARK: - Actions
    @objc fileprivate func brBtnCLicked() {
        setupTableView()
    }
    
    @objc fileprivate func deleteBtnClicked() {
        Request.deleteAll(fromMOC: mainContext)
    }
    
    // MARK: - Fileprivate
    fileprivate var dataSource: CoreDataTableViewDataSource<NotificationCell>!
    fileprivate let bag = DisposeBag()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Notification"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteBtnClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cc", style: .plain, target: self, action: #selector(brBtnCLicked))
    }
    
    fileprivate func setupObserver() {
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        
        let request = Request.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 20
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: mainContext, sectionNameKeyPath: #keyPath(Request.sectionTitle), cacheName: nil)

        dataSource = CoreDataTableViewDataSource(tableView:tableView, fetchedResultsController:frc, parentViewController: self)
    }
}

extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TimeHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

//extension NotificationViewController: TableViewDataSourceDelegate {
//    typealias Object = Request
//    typealias Cell = NotificationCell
//    func configure(_ cell: NotificationCell, for object: Request) {
//        cell.configure(withRequest: object)
//    }
//}


extension NotificationViewController {
    fileprivate func setupUI() {
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
