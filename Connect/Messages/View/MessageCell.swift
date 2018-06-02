//
//  MessageCell.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/25/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class MessageCell: CoreDataReusableTableViewCell {
    
    
    
//class MessageCell: ReusableTableViewCell {
    //    typealias Object = Dummy
    
    typealias Object = Message
    
    // UI
    fileprivate var partnerProfileImageView: UIImageView!
    fileprivate var textView: UITextView!
    fileprivate var sentImageView: UIImageView!
    
    fileprivate var timeStampLabel: UILabel!
    fileprivate var checkboxImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(withObject object: Message, parentViewController: UIViewController, currentIndexPath: IndexPath, userInfo: [String : Any]?) {
        textView.backgroundColor = .mainBlue
    }
    
    
    // MARK: - Actions
    
    // MARK: - Fileprivate
    fileprivate func adjustUI(forMessage message: Message) {
        if message.isSentByCurrentUser {
            // it's me who sends this message
            // constraints will be applied differently whether or not it's an image.
            
            
            
            
            
            
        } else {
            // it's one of my contacts who sends this message
            // constraints will be applied differently whether or not it's an image.
            
            partnerProfileImageView.image = message.fromUser.profilePhoto!.image
//            timeStampLabel.text = message.sentAt
            
            
            
        }
        
        
        
        
        
        
        
        
    }
}

extension MessageCell {
    fileprivate func setupUI() {
        
        partnerProfileImageView = UIImageView.create(withImageKey: .personPlaceHolder)
        
        textView = UITextView.create(text: "Your text will be shown in here. it might go more than 1 line", mainFontSize: 15)
        
        sentImageView = UIImageView.create(withImageKey: .personPlaceHolder)
        
        timeStampLabel = UILabel.create(text: "12:22 PM")
        
        
        let groupForCell:[UIView] = [partnerProfileImageView,textView, sentImageView, timeStampLabel]
        groupForCell.forEach(self.addSubview(_:))
        
        let frame = UIScreen.main.bounds
        partnerProfileImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-8)
            make.sizeEqualTo(width: 20, height: 20)
        }
        
        textView.snp.makeConstraints { (make) in
            textView.setCornerRadious(value: 5)
            make.left.equalToSuperview().offset(40)
            make.topBottomEqualToSuperView(withOffset: 1)
            make.width.equalTo(frame.width*2/3)
        }
        
        sentImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.topBottomEqualToSuperView(withOffset: 1)
            make.width.equalTo(200)
        }
        
        timeStampLabel.snp.makeConstraints { (make) in
            make.left.equalTo(textView.snp.right).offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }
        
        
        
        
        
    }
}
