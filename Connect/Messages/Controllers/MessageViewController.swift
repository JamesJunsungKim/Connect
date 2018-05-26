//
//  MessageViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class MessageViewController: UIViewController {
    // UI
    
    fileprivate var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVC()
        setupNavigationBar()
    }
    
    // MARK: - Actions
    
    @objc fileprivate func plusBtnClicked() {
        
    }
    
    // MARK: - Filepriavte
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Message"
    }
    
    fileprivate func setupNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus_icon"), style: .plain, target: self, action: #selector(plusBtnClicked))
    }
    
    
}
extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MessageCell.cell(fromTableView: tableView, atIndexPath: indexPath, configuration: { (messageCell) in
            messageCell.configure()
            messageCell.backgroundColor = .red
        })
    }
}

extension MessageViewController {
    fileprivate func setupUI() {
        tableview = UITableView(frame: .zero, style: .plain)
        tableview.setup(withCell: MessageCell(), delegate: self, dataSource: self)
        
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
