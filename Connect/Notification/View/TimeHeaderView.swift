//
//  TimeHeaderView.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/26/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class TimeHeaderView: UIView {
    
    // UI
    fileprivate var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        let text = titleLabel.text!
        titleLabel.sizeThatFits(CGSize(width: text.getWidth(), height: titleLabel.bounds.height))
    }
}

extension TimeHeaderView {
    fileprivate func setupUI(){
        titleLabel = UILabel.create(text: "Title", textAlignment: .center, textColor: .black, fontSize: 20, numberofLine: 1)
        titleLabel.backgroundColor = .white
        
        let separatorLine = UIView.create(withColor: .gray)
        let group: [UIView] = [separatorLine, titleLabel]
        let titleFrame = titleLabel.frame
        
        group.forEach(self.addSubview(_:))
        
        separatorLine.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(0.5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        
        
        
    }
}
