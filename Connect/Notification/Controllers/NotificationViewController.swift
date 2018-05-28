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
        enterViewControllerMemoryLogAndSaveToDisk(type: self.classForCoder)
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
    
    // MARK: - Fileprivate
    fileprivate weak var dataSource: CoreDataTableViewDataSource<Request, NotificationViewController>!
    fileprivate let bag = DisposeBag()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Notification"
    }
    
    fileprivate func setupObserver() {
//        AppStatus.current.requestObservable
//            .subscribe(onNext: {[unowned self] (request) in
//
//            }) {
//                logInfo("observer detached")
//        }.disposed(by: bag)
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        
        let request = Request.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 20
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: mainContext, sectionNameKeyPath: #keyPath(Request.sectionTitle), cacheName: nil)
        
        dataSource = CoreDataTableViewDataSource(tableView: tableView, fetchedResultsController: frc, dataSource: self)
    }
}

extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
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

extension NotificationViewController: TableViewDataSourceDelegate {
    typealias Object = Request
    typealias Cell = NotificationCell
    func configure(_ cell: NotificationCell, for object: Request) {
        cell.configure(withRequest: object)
    }
}


extension NotificationViewController {
    fileprivate func setupUI() {
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
