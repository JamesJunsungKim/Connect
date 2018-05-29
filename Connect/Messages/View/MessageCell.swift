//
//  MessageCell.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/25/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class MessageCell: ReusableTableViewCell {
    // UI
    
    fileprivate var partnerProfileImageView: UIImageView!
    fileprivate var bubbleView: UIView!
    fileprivate var textView: UITextView!
    fileprivate var sentImageView: UIImageView!
    
    fileprivate var timeStampLabel: UILabel!
    fileprivate var checkboxImageView: UIImageView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    // MARK: - Public
    public func configure(withMessage message: Message) {
        
        
    }
    
    // MARK: - Actions
    
    // MARK: - Fileprivate
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessageCell {
    fileprivate func setupUI() {
        
        partnerProfileImageView = UIImageView.create(withImageKey: .personPlaceHolder)
        
        bubbleView = UIView.create(withColor: .gray)
        
        textView = UITextView.create(text: "Your text will be shown in here. it might go more than 1 line", mainFontSize: 15)
        
        sentImageView = UIImageView.create(withImageKey: .personPlaceHolder)
        
        
        
        
    }
}
