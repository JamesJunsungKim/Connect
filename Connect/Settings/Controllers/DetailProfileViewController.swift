//
//  DetailProfileViewController.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/13/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit
import ARSLineProgress
import RxSwift

fileprivate enum SectionTitle: Int {
    case status, accountDetail, privateAccount, signOut
}

class DetailProfileViewController: UIViewController {
    
    // UI
    fileprivate var profileView: UIView!
    fileprivate var profileButton: UIButton!
    fileprivate var nameLabel: UILabel!
    fileprivate var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupVC()
        addTarget()

    }
    
    deinit {
        leaveViewControllerMomeryLogAndSaveDataToDisk(type: self.classForCoder)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func profileImageTapped() {
        presentImagePicker(pickerDelegate: self)
    }
    
    @objc fileprivate func nameTapped() {
        let targetAttribute = userSettingAttributes.first(where: {$0.contentType == .name})!
        let userInfo: [String:Any] = [SettingAttribute.Key.settingAttribute: targetAttribute]
        presentDefaultVC(targetVC: EditSettingDetailViewController(), userInfo: userInfo)
    }
    
    // MARK: - Filepriavte
    
    fileprivate var userSettingAttributes = User.settingAttributes()
    fileprivate var user = AppStatus.observer.currentUser!
    
    fileprivate let bag = DisposeBag()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        AppStatus.observer.userObservable
            
            .subscribe(
            onNext: {[unowned self] (user) in
                // set profile photo
                if self.profileButton.currentImage != user.profilePhoto?.image {
                    self.profileButton.setImage(user.profilePhoto!.image, for: .normal)
                }
                
                self.nameLabel.text = user.name
        },
            onDisposed: {
                //TODO: what should I do?
                logInfo("Disposed..")
        })
        .disposed(by: bag)
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
        switch SectionTitle(rawValue: section)! {
        case .status : return 1
        case .accountDetail: return 2
        case .privateAccount: return 1
        case .signOut: return 1
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
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 2 ? "If your account is private, your account only is searchable by your email." : nil
    }
    
    // MARK: - Tableview Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let attribute = targetAttribute(forIndexPath: indexPath)
        switch attribute.type {
        case .label:
            switch attribute.contentType {
            case .email: break
            default:
                presentDefaultVC(targetVC: EditSettingDetailViewController(), userInfo: [User.Key.user:user, SettingAttribute.Key.settingAttribute: targetAttribute(forIndexPath: indexPath)])
            }
        case .toggle: break
            
        case .onlyAction:
        presentDefaultAlert(withTitle: "Confirmation", message: "Are you sure to sign out? All data will be removed from your device.", okAction: {[unowned self] in
            self.user.signOut(success: {
                User.deleteAll(fromMOC: mainContext)
                Photo.deleteAll(fromMOC: mainContext)
                Message.deleteAll(fromMOC: mainContext)
                
                UserDefaults.userRequestToSignOut()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchToSignUpWindow()
                
            }, failure: { (error) in
                self.presentDefaultError(message: error.localizedDescription, okAction: nil)
            })
        }, cancelAction: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = unwrapEditImageOrOriginal(fromInfo: info)?.withRenderingMode(.alwaysOriginal) else {fatalError("Image must exist")}
        profileButton.setImage(image, for: .normal)
        
        picker.dismiss(animated: true) {[unowned self] in
            ARSLineProgress.ars_showOnView(self.view)
        }
        
        Photo.createAndUpload(into: mainContext, toReference: FireStorage.profilePhoto(user).reference , withImage: image, withType: .profileResolution, success: {[unowned self] (photo) in
            self.user.setProfilePhoto(with: photo)
            self.user.patch(toNode: User.Key.profilePhoto + Photo.Key.url, withValue: photo.url!, success: {
               ARSLineProgress.showSuccess()
            }, failure: {[unowned self] (error) in
                self.presentDefaultError(message: error.localizedDescription, okAction: nil)
            })
        }) {[unowned self] error in
            ARSLineProgress.hide()
            self.presentDefaultError(message: error.localizedDescription, okAction: nil)
        }
        
    }
}


extension DetailProfileViewController:DefaultViewController {
    
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
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
            make.size.equalTo(CGSize(width: view.bounds.width, height: 155))
        }
        
        profileButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 100, height: 100))
            profileButton.setCornerRadious(value: 50)
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
            tableView.contentInset = UIEdgeInsetsMake(getHeightOfNavigationBarAndStatusBar() - 5, 0, 0, 0)
            
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}








