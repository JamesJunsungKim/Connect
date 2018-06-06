//
//  SetupDetailAccountViewController.swift
//  Connect
//
//  Created by James Kim on 5/10/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import FirebaseStorage
import ARSLineProgress
import CoreData
class SetupDetailAccountViewController: DefaultViewController {
    
    // UI
    fileprivate var profileImageButton: UIButton!
    fileprivate var finishButton: UIButton!

    init(context:NSManagedObjectContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
        addtarget()
    }
    
    deinit {
        leaveViewControllerMomeryLog(type: self.classForCoder)
    }
    
    // MARK: - Actions
    @objc fileprivate func didTapImage() {
        presentImagePicker(pickerDelegate: self)
    }
    
    @objc fileprivate func finishBtnClicked() {
        ARSLineProgress.ars_showOnView(view)
        Photo.createAndUpload(into: context, toReference: FireStorage.profilePhoto(user).reference , withImage: profileImageButton.currentImage!, withType: .profileResolution, success: {[unowned self] (photo) in
            self.user.setProfilePhoto(with: photo)
            self.user.uploadToServer(success: {
                ARSLineProgress.showSuccess(andThen: {[unowned self] in
                    UserDefaults.store(object: self.user.uid!, forKey: .uidForSignedInUser)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.switchToMainWindow(user: self.user)
                })
            }, failure: {[unowned self] (error) in
                ARSLineProgress.hide()
                self.presentDefaultError(message: error.localizedDescription, okAction: nil)
            })
        }) {[unowned self] error in
            ARSLineProgress.hide()
            self.presentDefaultError(message: error.localizedDescription, okAction: nil)
        }
        
    }
    
    // MARK: - Fileprivate
    fileprivate var user: User!
    fileprivate let context: NSManagedObjectContext
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
    }
    
    fileprivate func addtarget() {
        profileImageButton.addTarget(self, action: #selector(didTapImage), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(finishBtnClicked), for: .touchUpInside)
    }
}

extension SetupDetailAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = unwrapEditImageOrOriginal(fromInfo: info)?.withRenderingMode(.alwaysOriginal) else {fatalError("Image must exist")}
        picker.dismiss(animated: true, completion: nil)
        profileImageButton.setImage(image, for: .normal)
        finishButton.isEnabled = true
    }
}

// UI
extension SetupDetailAccountViewController {
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        self.user = User.unwrapSingleInstanceFrom(userInfo: userInfo)
    }
    
    fileprivate func setupUI(){
        profileImageButton = UIButton.create(withImageName: "profile_image")
        profileImageButton.setCornerRadious(value: 60)
        
        let profileTitleLabel = UILabel.create(text: "Set a profile photo", textAlignment: .center, textColor: .black, fontSize: 21, numberofLine: 1)
        
        let profileDescriptionLabel = UILabel.create(text: "Please set your profile so that \npeople can recognize you easily", textAlignment: .center, textColor: .black, fontSize: 17, numberofLine: 0)
        
        finishButton = UIButton.create(title: "Finish", titleColor: .white, fontSize: 17, backgroundColor: .mainBlue)
        finishButton.setCornerRadious(value: 10)
        finishButton.isEnabled = false
        
        let group: [UIView] = [profileImageButton, profileTitleLabel, profileDescriptionLabel, finishButton]
        group.forEach(view.addSubview(_:))
        
        profileImageButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.width.height.equalTo(120)
        }
        
        profileTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageButton.snp.bottom).offset(10)
        }
        
        profileDescriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileTitleLabel.snp.bottom).offset(20)
            make.width.equalTo(280)
            make.height.equalTo(60)
        }
        
        finishButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileDescriptionLabel.snp.bottom).offset(60)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
}









