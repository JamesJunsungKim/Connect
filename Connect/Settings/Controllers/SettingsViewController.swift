//
//  SettingsViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit

class SettingsViewController: UIViewController, UserInvolvedController {
    
    // UI
    fileprivate var tableView: UITableView!
    fileprivate var profileImageView: UIImageView!
    fileprivate var namelabel: UILabel!
    fileprivate var statusLabel: UILabel!
    
    public var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
    }
    
    deinit {
        leaveMomeryLog(type: self.classForCoder)
    }
    
    //MARK: - Filepriavte
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Settings"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate var settings = Setting.fetchDefaultSettings()
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Tableview datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 3
        case 2: return 2
        default: fatalError()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as! ProfileCell
            cell.configure(withUser: user)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as! SettingCell
            let targetSetting = settings.first(where: {$0.type.indexPath == indexPath})!
            cell.configure(withSetting: targetSetting)
            return cell
        }
    }
    
    // MARK: - TableView delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // go to edit profile
            presentDefaultVC(targetVC: DetailProfileViewController(), userInfo: [User.Key.user:user])
        } else {
            // go to change settings.
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "PROFILE"
        case 1: return "SETTINGS"
        case 2: return "ABOUT"
        default: fatalError()
        }
    }
}

extension SettingsViewController {
    fileprivate func setupUI() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseIdentifier)
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}












