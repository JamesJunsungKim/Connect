//
//  NotificationViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class NotificationViewController: UIViewController {

    // UI
    
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
        
        dataSource.update(data: [Dummy(),Dummy(),Dummy(),Dummy(),Dummy()])
    }
    
    deinit {
        leaveViewControllerMomeryLogAndSaveDataToDisk(type: self.classForCoder)
    }

    // MARK: - Public
    
    // MARK: - Actions
    
    // MARK: - Fileprivate
    fileprivate var dataSource: DefaultTableViewDataSource<NotificationViewController>!
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Notification"
    }
}

extension NotificationViewController: UITableViewDelegate {
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
    typealias Object = Dummy
    typealias Cell = NotificationCell
    func configure(_ cell: NotificationCell, for object: Dummy) {
        
    }
}


extension NotificationViewController {
    fileprivate func setupUI() {
        
        tableView = UITableView(frame: .zero, style: .plain)
        dataSource = DefaultTableViewDataSource.init(tableView: tableView, sourceDelegate: self, tableViewDelegate: self)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
