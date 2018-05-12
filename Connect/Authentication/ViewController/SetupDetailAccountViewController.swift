//
//  SetupDetailAccountViewController.swift
//  Connect
//
//  Created by James Kim on 5/10/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import PKHUD

class SetupDetailAccountViewController: UIViewController {
    
    // UI
    fileprivate var profileImage: UIImageView!
    fileprivate var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVC()
        addtarget()
    }
    
    // MARK: - Actions
    @objc fileprivate func didTapImage() {
        presentImagePicker(pickerDelegate: self)
    }
    
    @objc fileprivate func finishBtnClicked() {
        // save the pictures to database
        
        // create a coredata instance for this user
        
        // switch the root vc to the main tab bar controller
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.switchToMainWindow()
    }
    
    // MARK: - Fileprivate
    fileprivate var user: NonCDUser!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
    }
    
    fileprivate func addtarget() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profileImage.addGestureRecognizer(tap)
    }
    
}

extension SetupDetailAccountViewController: DefaultViewController {
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        let user = NonCDUser.unwrapFrom(userInfo: userInfo!)
        self.user = user
    }
}

extension SetupDetailAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = unwrapEditImageOrOriginal(fromInfo: info) else {fatalError("Image must exist")}
        profileImage.setImage(with: image)
        finishButton.isEnabled = true
    }
}

// UI
extension SetupDetailAccountViewController {
    fileprivate func setupUI(){
        profileImage = UIImageView.create(image: UIImage(named: "profile_image")!)
        profileImage.isUserInteractionEnabled = true
        
        let profileTitleLabel = UILabel.create(text: "Set a profile photo", textAlignment: .center, textColor: .black, fontSize: 21, numberofLine: 1)
        
        let profileDescriptionLabel = UILabel.create(text: "Please set your profile so that \npeople can recognize you easily", textAlignment: .center, textColor: .black, fontSize: 17, numberofLine: 0)
        
        finishButton = UIButton.create(title: "Finish", titleColor: .white, fontSize: 17, backgroundColor: .mainBlue)
        finishButton.setCornerRadious(value: 10)
        finishButton.isEnabled = false
        
        let group: [UIView] = [profileImage, profileTitleLabel, profileDescriptionLabel, finishButton]
        group.forEach(view.addSubview(_:))
        
        profileImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.width.height.equalTo(120)
        }
        
        profileTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(10)
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








