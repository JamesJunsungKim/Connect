//
//  AddContactViewController.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/22/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import ARSLineProgress
import SnapKit

class AddContactViewController: DefaultViewController {
    
    // UI
    fileprivate var typeSegment: UISegmentedControl!
    fileprivate var textfield: UITextField!
    fileprivate var searchButton: UIButton!
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
        addTargets()
    }
    
    deinit {
        leaveViewControllerMomeryLog(type: self.classForCoder)
    }
    
    // MARK: - Actions
    @objc fileprivate func segmentValueChanged() {
        textfield.placeholder = typeSegment.selectedSegmentIndex == 0 ? emailPlaceholder:namePlaceholder
        textfield.text = ""
    }
    
    @objc fileprivate func searchBtnClicked() {
        guard let input = textfield.text, !input.isEmpty else {return}
        textfield.resignFirstResponder()
        ARSLineProgress.ars_showOnView(view)
        User.getList(withInput: input, selectedType: typeSegment.selectedTitle()) {[unowned self] (list_) in
            
            let list = list_.removeElement(condition: {$0.uid == self.appStatus.user.uid})
            
            guard list.count != 0 else {
                ARSLineProgress.hide()
                self.presentDefaultAlertWithoutCancel(withTitle: "Error", message: "Couldn't find anyone that matches your input.\nIf the person is set private, you can't search them by name")
                return
            }
            ARSLineProgress.hide()
            self.dataSource.update(data: [0:list])
        }
    }
    
    fileprivate func userDidselectedCell(atIndexPath indexPath: IndexPath) {
        let currentUser = appStatus.user
        
        let targetUser = dataSource.object(atIndexPath: indexPath)
        presentActionSheetWithCancel(title: "Would you like to add this person?", message: nil, firstTitle: "Send a request", firstAction: {[unowned self] in
            //check this user is not saved to disk..
            
            // TODO: To enable to check if the target user is already in system
//            guard User.findOrFetch(forUID: targetUser.uid) == nil else {
//                self.presentDefaultAlertWithoutCancel(withTitle: "Error", message: "You already sent a request!")
//                return
//            }
            
            let toUser = targetUser.convertAndCreateUser(in: self.appStatus.mainContext)
            let request = Request.create(into: self.appStatus.mainContext, fromUser: self.appStatus.user, toUser: toUser, urgency: .normal, requestType: .friendRequest)
            currentUser.insert(request: request, intoSentNode: true)
            request.uploadToNodeOfSentRequestsAndReceivedRequests(success: {[unowned self] in
                self.presentDefaultAlertWithoutCancel(withTitle: "Succeed", message: nil)
                }, failure: {[unowned self] (error) in
                    self.presentDefaultError(message: error.localizedDescription, okAction: nil)
            })
        }
    )}
    
    // MARK: - Fileprivate
    fileprivate let appStatus: AppStatus
    fileprivate var dataSource : DefaultTableViewDataSource<ContactCell>!
    fileprivate let emailPlaceholder = "Search your contacts by email"
    fileprivate let namePlaceholder = "Search your contacts by name"
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }
    
    fileprivate func addTargets() {
        typeSegment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        searchButton.addTarget(self, action: #selector(searchBtnClicked), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AddContactViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBtnClicked()
        return true
    }
}

extension AddContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userDidselectedCell(atIndexPath: indexPath)
    }
}

extension AddContactViewController {
    fileprivate func setupUI() {
        
        typeSegment = UISegmentedControl.create(withTitles: ["Name","Email"], tintColor: .mainBlue)
        
        textfield = UITextField.create(placeHolder: emailPlaceholder, textSize: 15, textColor: .black, keyboardType: .default)
        textfield.delegate = self
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.autocorrectionType = .no
        textfield.setBorder(color: .mainBlue, width: 0.5)
        textfield.setCornerRadious(value: 5)
        
        
        searchButton = UIButton.create(title: "Search", titleColor: .white, fontSize: 17, backgroundColor: .mainBlue)
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        dataSource = DefaultTableViewDataSource<ContactCell>.init(tableView: tableView, parentViewController: self, initialData: nil)

        let group: [UIView] = [typeSegment, textfield, searchButton, tableView]
        
        group.forEach(view.addSubview(_:))
        
        typeSegment.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(getHeightOfNavigationBarAndStatusBar()+10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        textfield.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(typeSegment)
            make.top.equalTo(typeSegment.snp.bottom).offset(15)
            make.height.equalTo(30)
        }
        
        searchButton.snp.makeConstraints { (make) in
            searchButton.setCornerRadious(value: 10)
            make.centerX.equalToSuperview()
            make.top.equalTo(textfield.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchButton.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        
        
    }
}


