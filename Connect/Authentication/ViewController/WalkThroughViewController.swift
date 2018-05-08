//
//  WalkThroughViewController.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

class WalkThroughViewController: UIViewController {
    
    // UI
    fileprivate var collectionView: UICollectionView!
    fileprivate var pageControl: UIPageControl!
    fileprivate var createButton: UIButton!
    fileprivate var signInDescriptionLabel: UILabel!
    fileprivate var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        addTargets()
    }
    
    
    //MARK: - Actions
    
    
    //MAKR: - Fileprivate
    fileprivate let pages = Page.fetchPages()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
    }
    fileprivate func addTargets() {
        
    }
    
}

extension WalkThroughViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.cellId, for: indexPath) as! PageCell
        cell.configure(withPage: pages[indexPath.item])
        return cell
    }
}

// MARK: - Setup UI
extension WalkThroughViewController {
    fileprivate func setupUI() {
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height*4/7)
            layout.minimumLineSpacing = 0
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.register(PageCell.self, forCellWithReuseIdentifier: PageCell.cellId)
            cv.backgroundColor = .white
            cv.isPagingEnabled = true
            cv.dataSource = self
            return cv
        }()
        
        pageControl = {
            let pc = UIPageControl(frame: .zero)
            pc.pageIndicatorTintColor = .lightGray
            pc.currentPageIndicatorTintColor = UIColor.mainBlue
            pc.numberOfPages = pages.count
            return pc
        }()
        
        createButton = {
            let bt = UIButton(type: .system)
            bt.backgroundColor = .mainBlue
            bt.setTitleColor(.white, for: .normal)
            let attributedString = NSAttributedString(string: "Create Account", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 15)])
            bt.setAttributedTitle(attributedString, for: .normal)
            return bt
        }()
        
        signInDescriptionLabel = {
            let label = UILabel()
            label.text = "Already Have an ID?"
            label.font = UIFont(name: "Avenir Next", size: 17)
            return label
        }()
        
        signInButton = {
            let bt = UIButton()
            bt.setTitleColor(.mainBlue, for: .normal)
            bt.setTitle("Sign In", for: .normal)
            return bt
        }()
        
        let stackView: UIStackView = {
            let sv = UIStackView()
            sv.axis = .horizontal
            sv.alignment = .center
            sv.distribution = .equalSpacing
            sv.spacing = 7
            sv.addArrangedSubview(signInDescriptionLabel)
            sv.addArrangedSubview(signInButton)
            return sv
        }()
        
        let groupsForSubviews:[UIView] = [collectionView, pageControl,createButton, stackView]
        groupsForSubviews.forEach(view.addSubview(_:))
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView).offset(10)
            make.centerX.equalTo(view)
        }
        
        createButton.snp.makeConstraints { (make) in
            make.top.equalTo(pageControl).offset(15)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(createButton).offset(15)
            make.width.equalTo(200)
            make.height.equalTo(35)
        }
        
        
        
        
        
        
        
        
    }
}














