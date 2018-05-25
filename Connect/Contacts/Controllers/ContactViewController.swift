//
//  ContactViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class ContactViewController: UIViewController {
    
    // UI
    
    fileprivate var tableview: UITableView!
    
    public var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
    }
    
    deinit {
        leaveViewControllerMomeryLogAndSaveDataToDisk(type: self.classForCoder)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func searchBtnClicked() {
        hideOrShowSearchBar(needsToShow: true)
    }
    
    @objc fileprivate func plusBtnClicked() {
        presentDefaultVC(targetVC: AddContactViewController(), userInfo: nil)
    }
    
    
    
    // MARK: - Filepriavte
    
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
    
    
}

extension ContactViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideOrShowSearchBar(needsToShow: false)
    }
}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    // Tableview Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as! ContactCell
        return cell
    }
    
    // Tableview Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


extension ContactViewController {
    fileprivate func setupUI() {
        tableview = UITableView(frame: .zero, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        ContactCell.register(withTableview: tableview)
        
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}








