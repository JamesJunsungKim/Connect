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
        titleLabel = UILabel.create(text: "2018-08-11", textAlignment: .center, textColor: .black, fontSize: 14, numberofLine: 1)
        
        let group: [UIView] = [titleLabel]
        
        group.forEach(self.addSubview(_:))
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        
    }
}
