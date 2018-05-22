//
//  ContactViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class ContactViewController: UIViewController, UserInvolvedController {
    
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
        
    }
    
    @objc fileprivate func plusBtnClicked() {
        
    }
    
    
    
    // MARK: - Filepriavte
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Contacts"
        
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
    
    
}

extension ContactViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableview.contentOffset.y > 0 ? hideOrShowNavigationItems(needsToShow: true): hideOrShowNavigationItems(needsToShow: false)
    }
}


extension ContactViewController {
    fileprivate func setupUI() {
        tableview = UITableView(frame: .zero, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseIdentifier)
        
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}








