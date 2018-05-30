//
//  MessageDetailViewController.swift
//  Connect
//
//  Created by James Kim on 5/29/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData


class MessageDetailViewController: UIViewController{
    
    //UI
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()  
        setupVC()
        addTargets()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideOrShowTabbar(needsToShow: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideOrShowTabbar(needsToShow: true)
    }
    
    // MARK: - Public
    
    // MARK: - Actions
    
    // MARK: - Filepriavte
    fileprivate weak var targetUser: User!
//    fileprivate var dataSource : CoreDataTableViewDataSource<MessageCell>!
    fileprivate var dataSource___ : DefaultTableViewDataSource<MessageCell>!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
    }
    
    fileprivate func addTargets() {
        
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
//        dataSource___ = DefaultTableViewDataSource.init(tableView: tableView, sourceDelegate: self, initialData: [Dummy(),Dummy(),Dummy(),Dummy()])
        dataSource___ = DefaultTableViewDataSource(tableView: tableView, parentViewController: self, initialData: [Dummy(),Dummy(),Dummy(),Dummy()])
        
//        let fromUserPredicate = NSPredicate(format: "%K == %@", #keyPath(Message.fromUser.uid), targetUser.uid!)
//        let toUserPredicate = NSPredicate(format: "%K == %@", #keyPath(Message.toUser.uid), targetUser.uid!)
//        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromUserPredicate, toUserPredicate])
//        let request = Message.sortedFetchRequest(with: predicate)
//        request.returnsObjectsAsFaults = false
//        request.fetchBatchSize = 20
//
//        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: mainContext, sectionNameKeyPath: nil, cacheName: nil)
        

    }
    
    fileprivate func hideOrShowTabbar(needsToShow flag:Bool) {
        if flag {
            self.tabBarController?.tabBar.layer.zPosition = 0
        } else {
            self.tabBarController?.tabBar.layer.zPosition = -1
        }
    }
    
    
}
extension MessageDetailViewController: UITableViewDelegate {
    // Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension MessageDetailViewController: DefaultViewController {
    
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
//        targetUser = User.unwrapFrom(userInfo: userInfo)
    }
    
    fileprivate func setupUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}











