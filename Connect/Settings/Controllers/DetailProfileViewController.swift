//
//  DetailProfileViewController.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

class DetailProfileViewController: UIViewController, UserInvolvedController {
    
    // UI
    fileprivate var profileView: UIView!
    fileprivate var profileButton: UIButton!
    fileprivate var nameLabel: UILabel!
    
    fileprivate var tableView: UITableView!
    
    
    public var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterMemoryLog(type: self.classForCoder)
        setupVC()
        addTarget()

    }
    
    deinit {
        leaveMomeryLog(type: self.classForCoder)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func profileImageTapped() {
        
    }
    
    @objc fileprivate func nameTapped() {
        presentDefaultVC(targetVC: EditSettingDetailViewController(), userInfo: [User.Key.user:user])
    }
    
    // MARK: - Filepriavte
    
    fileprivate let userSettingAttributes = SettingAttribute.userSettingAttributes()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }
    
    fileprivate func addTarget() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(nameTapped))
        nameLabel.addGestureRecognizer(tap)
        
        profileButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
    }
    
    fileprivate func configureUI() {
        profileButton.setImage(user.profilePhoto!.image.withRenderingMode(.alwaysOriginal), for: .normal)
        nameLabel.text = user.name
    }
    
    fileprivate func targetAttribute(forIndexPath indexPath: IndexPath) -> SettingAttribute {
        return userSettingAttributes.first(where: {$0.targetIndexPath == indexPath})!
    }
    
}

extension DetailProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK:- Tableview DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 2
        case 2: return 1
        case 3: return 1
        default: fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingAttributeCell.reuseIdentifier, for: indexPath) as! SettingAttributeCell
        cell.configure(withAttribute: targetAttribute(forIndexPath: indexPath), withUser: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? profileView : nil
    }
    
    // MARK: - Tableview Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch targetAttribute(forIndexPath: indexPath).type {
        case .label: break
        case .toggle: break
        case .onlyAction:
        presentDefaultAlert(withTitle: "Confirmation", message: "Are you sure to sign out? All data will be removed. it can not be undo.", okAction: {[unowned self] in
            self.user.signOut(success: {
                // remove data for user and messages.
                User.deleteAll(fromMOC: mainContext)
                Photo.deleteAll(fromMOC: mainContext)
//                Message.deleteAll(fromMOC: mainContext)
                
                UserDefaults.removeValue(forKey: .uidForSignedInUser)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchToSignUpWindow()
                
            }, failure: { (error) in
                self.presentDefaultError(message: error.localizedDescription, okAction: nil)
            })
        }, cancelAction: nil)
        }
    }
    
    
    
}

extension DetailProfileViewController:DefaultViewController {
    
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        user = User.unwrapFrom(userInfo: userInfo!)
        setupUI()
        configureUI()
    }
    
    fileprivate func setupUI(){
        profileView = UIView.create(withColor: .white)
        
        profileButton = UIButton.create(withImageName: "profile_image")
        nameLabel = UILabel.create(text: "Name", textAlignment: .center, textColor: .black, fontSize: 17, numberofLine: 1)
        nameLabel.isUserInteractionEnabled = true
        
        let pencilImageView = UIImageView.create(withImageName: "gray_pencil")
        
        let group: [UIView] = [profileButton, nameLabel, pencilImageView]
        group.forEach(profileView.addSubview(_:))
        
        profileView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.bounds.width, height: 160))
        }
        
        profileButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(25)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileButton.snp.bottom).offset(10)
        }
        
        pencilImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.left.equalTo(nameLabel.snp.right).offset(5)
        }
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SettingAttributeCell.self, forCellReuseIdentifier: SettingAttributeCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            tableView.contentInset = UIEdgeInsetsMake(getHeightOfNavigationBarAndStatusBar(), 0, 0, 0)
            
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}








