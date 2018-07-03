//
//  NotificationCell.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/26/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import RxSwift

class NotificationCell: CoreDataReusableTableViewCell {
    typealias Object = Request
    
    // UI
    fileprivate var profileImageView: UIImageView!
    fileprivate var descriptionLabel: UILabel!
    fileprivate var actionButton: UIButton!
    fileprivate var sentDateLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    public var actionButtnClickObservable: Observable<Request> {
        return requestSubject.asObservable()
    }
    
    public func setup(withObject object: Request, parentViewController: UIViewController, currentIndexPath: IndexPath, userInfo: [String : Any]?) {
        configure(withRequest: object)
    }
    
    public func configure(withRequest request: Request) {
        self.request = request
        profileImageView.image = request.fromUser.profilePhoto!.image
        
        switch request.requestType {
        case .friendRequest:
            descriptionLabel.text = "\(request.fromUser.name) sent you a friend request"
            actionButton.setTitleWhileKeepingAttributes(title: "Accept")
        }
    }
    
    // MARK: - Actions
    @objc fileprivate func actionBtnClicked() {
        requestSubject.onNext(request)
    }
    
    // MARK: - Fileprivate
    fileprivate weak var request: Request!
    fileprivate let requestSubject = PublishSubject<Request>()
    
    fileprivate func addTarget() {
        actionButton.addTarget(self, action: #selector(actionBtnClicked), for: .touchUpInside)
    }
    
}


extension NotificationCell {
    fileprivate func setupUI() {
        profileImageView = UIImageView.create(withImageKey: .personPlaceHolder)
        
        descriptionLabel = UILabel.create(text: "Someone sent you a friend request", textAlignment: .left, textColor: .black, fontSize: 12, numberofLine: 0)
        
        actionButton = UIButton.create(title: "Action", titleColor: .white, fontSize: 14, backgroundColor: .mainBlue)
        sentDateLabel = UILabel.create(text: "2 days ago", textAlignment: .left, textColor: .gray, fontSize: 10, boldFont: false, numberofLine: 1)
        
        let group: [UIView] = [profileImageView, descriptionLabel, actionButton, sentDateLabel]
        group.forEach(self.addSubview(_:))
        
        let height = bounds.height
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: height*5/6, height: height*5/6))
            make.left.equalToSuperview().offset(10)
            profileImageView.setCornerRadious(value: height*5/6*0.5)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(5)
            make.right.equalTo(actionButton.snp.left).offset(-5)
        }
        
        actionButton.snp.makeConstraints { (make) in
            actionButton.setCornerRadious(value: 5)
            make.centerY.equalTo(profileImageView)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 90, height: 30))
        }
        
        sentDateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(descriptionLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(2)
        }
    }
}
