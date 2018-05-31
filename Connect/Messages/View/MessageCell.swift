//
//  MessageCell.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/25/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class MessageCell: ReusableTableViewCell {
    
    typealias Object = Dummy
    
    // UI
    
    fileprivate var partnerProfileImageView: UIImageView!
    fileprivate var bubbleView: UIView!
    fileprivate var textView: UITextView!
    fileprivate var sentImageView: UIImageView!
    
    fileprivate var timeStampLabel: UILabel!
    fileprivate var checkboxImageView: UIImageView!
    
    // MARK: - Public
    public func setup(withObject object: Dummy, parentViewController: UIViewController, currentIndexPath: IndexPath) {
        setupUI()
        sentImageView.isHidden = true
        bubbleView.backgroundColor = .mainBlue
    }
    
    public func configure() {
        sentImageView.isHidden = true
        bubbleView.backgroundColor = .mainBlue
    }
    
    public func configure(withMessage message: Message) {
        
    }
    
    // MARK: - Actions
    
    // MARK: - Fileprivate
    
}

extension MessageCell {
    fileprivate func setupUI() {
        
        partnerProfileImageView = UIImageView.create(withImageKey: .personPlaceHolder)
        
        bubbleView = UIView.create(withColor: .gray)
        
        textView = UITextView.create(text: "Your text will be shown in here. it might go more than 1 line", mainFontSize: 15)
        
        sentImageView = UIImageView.create(withImageKey: .personPlaceHolder)
        
        timeStampLabel = UILabel.create(text: "12:22 PM")
        
        bubbleView.addSubview(textView)
        
        let groupForCell:[UIView] = [partnerProfileImageView, bubbleView, sentImageView, timeStampLabel]
        groupForCell.forEach(self.addSubview(_:))
        
        let frame = self.frame
        
        partnerProfileImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-8)
            make.sizeEqualTo(width: 20, height: 20)
        }
        
        bubbleView.snp.makeConstraints { (make) in
            bubbleView.setCornerRadious(value: 5)
            make.left.equalToSuperview().offset(40)
            make.topBottomEqualToSuperView(withOffset: 1)
            make.width.equalTo(frame.width*5/8)
        }
        
        textView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        sentImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.topBottomEqualToSuperView(withOffset: 1)
            make.width.equalTo(200)
        }
        
        timeStampLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bubbleView.snp.right).offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }
        
        
        
        
        
    }
}
