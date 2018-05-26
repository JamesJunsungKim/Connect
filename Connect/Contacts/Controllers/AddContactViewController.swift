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

class AddContactViewController: UIViewController {
    
    // UI
    
    fileprivate var typeSegment: UISegmentedControl!
    fileprivate var textfield: UITextField!
    fileprivate var searchButton: UIButton!
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
        addTargets()
    }
    
    deinit {
        leaveViewControllerMomeryLogAndSaveDataToDisk(type: self.classForCoder)
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
            
            var list = list_
            list.removeElement(condition: {$0.uid == AppStatus.observer.currentUser.uid})
            
            if self.typeSegment.selectedSegmentIndex == 0 {
                list.removeElement(condition: {$0.isPrivate})
            }
            
            guard list.count != 0 else {
                ARSLineProgress.hide()
                self.presentDefaultAlertWithoutCancel(withTitle: "Error", message: "Couldn't find anyone that matches your input.\nIf the person is set private, you can't search them by name")
                return
            }
            ARSLineProgress.hide()
            self.listOfContacts = list
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Fileprivate
    fileprivate let emailPlaceholder = "Search your contacts by email"
    fileprivate let namePlaceholder = "Search your contacts by name"
    fileprivate var listOfContacts = [NonCDUser]()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }
    
    fileprivate func addTargets() {
        typeSegment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        searchButton.addTarget(self, action: #selector(searchBtnClicked), for: .touchUpInside)
    }
}

extension AddContactViewController: UITableViewDelegate, UITableViewDataSource {
    // Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfContacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as! ContactCell
        cell.configure(withNonCDUser: listOfContacts[indexPath.row])
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetUser = listOfContacts[indexPath.row]
        presentActionSheetWithCancel(title: "Would you like to add this person?", message: nil, firstTitle: "Send a request", firstAction: {[unowned self]in
            //check this user is not saved to disk..
            let predicate = NSPredicate(format: "%K == %@", #keyPath(User.uid), targetUser.uid!)
            guard User.findOrFetch(in: mainContext, matching: predicate) == nil else {
                self.presentDefaultAlertWithoutCancel(withTitle: "Error", message: "This user is already in your contact.")
                return
            }
            
            
        }, cancelAction: nil, configuration: nil)
    }
}
extension AddContactViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBtnClicked()
        return true
    }
}


extension AddContactViewController: DefaultSegue {
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
        tableView.setup(withCell: ContactCell(), delegate: self, dataSource: self)

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


