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
    }
    
    @objc fileprivate func searchBtnClicked() {
        guard let text = textfield.text, !text.isEmpty else {return}
        textfield.resignFirstResponder()
        // Get a list of people that satisfy the predicate..
        User.getList(with: text, selectedType: "name")
    }
    
    // MARK: - Fileprivate
    fileprivate let emailPlaceholder = "Search your contacts by email"
    fileprivate let namePlaceholder = "Search your contacts by name"
    fileprivate var path: String!
    
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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as! ContactCell
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension AddContactViewController: DefaultViewController {
    fileprivate func setupUI() {
        
        typeSegment = UISegmentedControl.create(withTitles: ["Email","Name"], tintColor: .mainBlue)
        
        textfield = UITextField.create(placeHolder: emailPlaceholder, textSize: 15, textColor: .black, keyboardType: .default)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.autocorrectionType = .no
        textfield.setBorder(color: .mainBlue, width: 0.5)
        textfield.setCornerRadious(value: 5)
        
        searchButton = UIButton.create(title: "Search", titleColor: .white, fontSize: 17, backgroundColor: .mainBlue)
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self

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


