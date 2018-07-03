//
//  SettingsViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import UIKit
import SnapKit
import RxSwift

fileprivate enum SectionTitle: Int {
    case profile, setting, about
}

class SettingsViewController: DefaultViewController {
    
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
        
    }
    
    deinit {
        leaveViewControllerMomeryLogSaveData(type: self.classForCoder)
    }
    
    //MARK: - Filepriavte
    
    fileprivate let appStatus: AppStatus
    
    fileprivate var user: User {
        return appStatus.user
    }
    
    fileprivate var settings = Setting.fetchDefaultSettings()
    fileprivate let bag = DisposeBag()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Settings"
        
        // Observe the app status for UI changes.
        appStatus.userObservable
            .subscribe(
                onNext: {[unowned self] (user) in
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                },
                
                onDisposed: {
                    logInfo("user subscription is diposed.")
            })
            .disposed(by: bag)
    }
    
    fileprivate func targetSetting(forIndexPath indexPath: IndexPath) -> Setting {
        return settings.first(where: {$0.indexPath == indexPath})!
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Tableview datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SectionTitle(rawValue: section)! {
        case .profile: return 1
        case .setting: return 3
        case .about: return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionTitle(rawValue: indexPath.section)! {
        case .profile :
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as! ProfileCell
            cell.configure(withUser: user)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as! SettingCell
            cell.configure(withSetting: targetSetting(forIndexPath: indexPath))
            return cell
        }
    }
    
    // MARK: - TableView delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 70 : 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SectionTitle(rawValue: indexPath.section)! {
        case .profile:
            presentDefaultVC(targetVC: DetailProfileViewController(appStatus: appStatus), userInfo: nil)
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch SectionTitle(rawValue: section)! {
        case .profile: return "PROFILE"
        case .setting: return "SETTINGS"
        case .about: return "ABOUT"
        }
    }
}

extension SettingsViewController {
    fileprivate func setupUI() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.setup(withCell: ProfileCell(), delegate: self, dataSource: self)
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}












