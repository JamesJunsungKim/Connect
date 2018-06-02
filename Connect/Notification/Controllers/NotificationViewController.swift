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

class NotificationViewController: UIViewController, NameDescribable {

    // UI
    fileprivate var tableView: UITableView!
    
    init(appStatus:AppStatus) {
        self.appStatus = appStatus
        super.init(nibName: nil, bundle: nil)
    }
    
   
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
    
    fileprivate lazy var observeCell: (NotificationCell)->() = {[unowned self](cell) in
        cell.clickObservable.subscribe(onNext: { (request) in
            // what's the main goal here.
            // actions might be different depending on which request type it is
            
            switch request.requestType {
            case .friendRequest:
                // at first, add the user to the contact
                
                self.appStatus.addUserToContact(user: request.fromUser)
                request.completedByToUser(success: {[unowned self] in
                    //TODO: Think about what to do when it's completed.
                }) {[unowned self] (error) in
                    self.presentDefaultError(message: error.localizedDescription, okAction: nil)
                }
            }
        }, onDisposed: self.observerDisposedDescription)
            .disposed(by: self.bag)

    }
    
    // MARK: - Fileprivate
    fileprivate let appStatus: AppStatus
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

        dataSource = CoreDataTableViewDataSource<NotificationCell>(tableView: tableView, fetchedResultsController: frc, parentViewController: self, userInfo: nil, observableCell: observeCell)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
