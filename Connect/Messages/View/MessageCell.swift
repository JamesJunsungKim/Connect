//
//  MessageCell.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/25/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class MessageCell: CoreDataReusableTableViewCell {
    
    typealias Object = Message
    
    // UI
    fileprivate var partnerProfileImageView: UIImageView!
    fileprivate var textView: UITextView!
    fileprivate var sentImageView: UIImageView!
    
    fileprivate var timeStampLabel: UILabel!
    fileprivate var checkboxImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(withObject object: Message, parentViewController: UIViewController, currentIndexPath: IndexPath, userInfo: [String : Any]?) {
        setupUI()
        adjustUI(forMessage: object)
    }
    
    // MARK: - Actions
    
    // MARK: - Fileprivate
    fileprivate let targetWidth = UIScreen.main.bounds.width*2/3
    fileprivate let imageSidePadding:CGFloat = 40
    fileprivate let textViewSidePadding :CGFloat = 40
    
    fileprivate func adjustUI(forMessage message: Message) {
        let isImageMessage = message.isImageMessage
        let isSentByLoginUser = message.isSentByCurrentUser
        
        timeStampLabel.text = message.sentAt.toHourToAmPmStringUTC()
        partnerProfileImageView.image = message.fromUser.profilePhoto!.image
        partnerProfileImageView.isHidden = isSentByLoginUser
        textView.isHidden = isImageMessage
        textView.backgroundColor = isSentByLoginUser ? .gray : .mainBlue
        
        if message.isImageMessage {
            // position is determined by who sends the message
            sentImageView.snp.remakeConstraints { (make) in
                make.topBottomEqualToSuperView(withOffset: 0)
                make.width.equalTo(targetWidth)
                _ = message.isSentByCurrentUser ? make.right.equalToSuperview().offset(-imageSidePadding) : make.left.equalToSuperview().offset(imageSidePadding)
            }
        } else {
            textView.snp.remakeConstraints { (make) in
                _ = isSentByLoginUser ? make.right.equalToSuperview().offset(-textViewSidePadding) : make.left.equalToSuperview().offset(textViewSidePadding)
                make.width.equalTo(UITextView.estimateFrameForText(cellWidth: targetWidth, forText: message.text!).width)
                make.topBottomEqualToSuperView(withOffset: 0)
            }
        }
        
        timeStampLabel.snp.remakeConstraints { (make) in
            _ = isSentByLoginUser ? make.right.equalTo(isImageMessage ? sentImageView.snp.left : textView.snp.left).offset(-3) : make.left.equalTo(isImageMessage ? sentImageView.snp.right: textView.snp.right).offset(3)
            make.bottom.equalToSuperview().offset(-3)
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
            sentImageView.backgroundColor = .red
            make.left.equalToSuperview().offset(imageSidePadding)
            make.topBottomEqualToSuperView(withOffset: 0)
            make.width.equalTo(targetWidth)
        }
        
        timeStampLabel.snp.makeConstraints { (make) in
            make.left.equalTo(textView.snp.right).offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }
        
        
        
        
        
    }
}
