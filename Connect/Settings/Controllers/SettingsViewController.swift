//
//  SettingsViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    // UI
    fileprivate var tableView: UITableView!
    fileprivate var profileImageView: UIImageView!
    fileprivate var namelabel: UILabel!
    fileprivate var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        
    }
    
    //MARK: - Filepriavte
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Settings"
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Hi", for: indexPath)
        return cell
    }
}

extension SettingsViewController {
    fileprivate func setupUI() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HI")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}












