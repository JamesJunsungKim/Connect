//
//  ContactViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit
import CoreData

class ContactViewController: UIViewController {
    
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
    
    @objc fileprivate func searchBtnClicked() {
        hideOrShowSearchBar(needsToShow: true)
    }
    
    @objc fileprivate func plusBtnClicked() {
        presentDefaultVC(targetVC: AddContactViewController(appStatus: appStatus), userInfo: nil)
    }
    
    // MARK: - Filepriavte
    fileprivate let appStatus : AppStatus
    fileprivate var dataSource___: DefaultTableViewDataSource<ContactCell>!
//    fileprivate var datasource : CoreDataTableViewDataSource<User,ContactViewController>!
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var searchbarIsPresent = false
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Contacts"
        hideOrShowNavigationItems(needsToShow: true)
        
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
    }
    
    fileprivate func setupTableView() {
        tableview.delegate = self
        dataSource___ = DefaultTableViewDataSource<ContactCell>.init(tableView: tableview, parentViewController: self, initialData: [0:[NonCDUser(uid: "A", name: "HI", phoneNumber: nil, emailAddress: "B", isPrivate: false, isFavorite: false, isOwner: true, isSelected: false, contacts: [], profilePhoto: nil, groups: [])]], userInfo: nil, observableCell: nil)
        
        
//        let request = User.sortedFetchRequest
//        request.returnsObjectsAsFaults = false
//        request.fetchBatchSize = 20
//
//        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: mainContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        datasource = CoreDataTableViewDataSource(tableView: tableview, fetchedResultsController: frc, dataSource: self)
    }
    
    fileprivate func hideOrShowNavigationItems(needsToShow flag: Bool) {
        if flag {
            guard navigationItem.leftBarButtonItem == nil else {return}
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(searchBtnClicked))
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus_icon"), style: .plain, target: self, action: #selector(plusBtnClicked))
        } else {
            guard navigationItem.leftBarButtonItem != nil else {return}
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    fileprivate func hideOrShowSearchBar(needsToShow flag: Bool) {
        if flag {
            searchbarIsPresent = true
            navigationItem.titleView = searchController.searchBar
            hideOrShowNavigationItems(needsToShow: false)
        } else {
            searchbarIsPresent = false
            navigationItem.titleView = nil
            hideOrShowNavigationItems(needsToShow: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension ContactViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideOrShowSearchBar(needsToShow: false)
    }
}

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//extension ContactViewController: TableViewDataSourceDelegate {
//    typealias Object = Dummy
//    typealias Cell = ContactCell
//    
//    func configure(_ cell: ContactCell, for object: Dummy) {
//        
//    }
//}


extension ContactViewController {
    fileprivate func setupUI() {
        tableview = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}








