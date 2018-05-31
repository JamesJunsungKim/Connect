//
//  MessageDetailViewController.swift
//  Connect
//
//  Created by James Kim on 5/29/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import CoreData
import RxSwift

class MessageDetailViewController: UIViewController, NameDescribable{
    
    //UI
    fileprivate var tableView: UITableView!
    
    fileprivate var commentInputAccessroyView: CommentInputAccessoryView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()  
        setupVC()
        addTargets()
        setupTableView()
        setupObserver()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideOrShowTabbar(needsToShow: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideOrShowTabbar(needsToShow: true)
    }
    
    override var inputAccessoryView: UIView? {
        return commentInputAccessroyView
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Public
    
    // MARK: - Actions
    
    fileprivate var userDidTypeText: (String)->() = { _ in
        // TODO: need to make a new message based on the text
    }
    
    // MARK: - Filepriavte
    fileprivate weak var targetUser: User!
//    fileprivate var dataSource : CoreDataTableViewDataSource<MessageCell>!
    fileprivate var dataSource___ : DefaultTableViewDataSource<MessageCell>!
    fileprivate let bag = DisposeBag()
    
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
    
    fileprivate func setupObserver() {
        commentInputAccessroyView.textViewObservable.subscribe(
            onNext: userDidTypeText ,
            onDisposed: {
                logInfo("comment \(self.observerDisposedDescription)")
        })
        .disposed(by: bag)
    }
    
    fileprivate func hideOrShowTabbar(needsToShow flag:Bool) {
        tabBarController?.tabBar.layer.zPosition = flag ? 0 : -1
    }
    
    
}
extension MessageDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension MessageDetailViewController: DefaultViewController {
    
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
//        targetUser = User.unwrapFrom(userInfo: userInfo)
    }
    
    fileprivate func setupUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.keyboardDismissMode = .interactive
        
        commentInputAccessroyView = CommentInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
        
        let group:[UIView] = [tableView]
        group.forEach(view.addSubview(_:))
        
        tableView.snp.makeConstraints { (make) in
            make.left.bottom.top.right.equalTo(view.safeAreaLayoutGuide)
            tableView.contentInset = UIEdgeInsetsMake(0, 0, -40, 0)
            tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, -40, 0)
        }
    }
}











