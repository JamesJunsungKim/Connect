//
//  CommentInputAccessoryView.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/30/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import RxSwift


class CommentInputAccessoryView: UIView {
    // UI
    fileprivate var textView: UITextView!
    fileprivate var placeholderLabel: UILabel!
    fileprivate var submitButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupView()
        addTarget()
    }
    
    // MARK: - Public/Internal
    public func textViewObservable: Observable<String> {
        return textSubject.asObservable()
    }
    
    // MARK: - Actions
    
    @objc fileprivate func submitBtnClicked() {
        textSubject.onNext(textView.text)
        textView.text = nil
        showOrHidePlaceHolder()
    }
    
    // MARK: - Fileprivate
    fileprivate var textSubject = PublishSubject<String>()
    
    fileprivate func setupView() {
        autoresizingMask = .flexibleHeight
    }
    
    fileprivate func addTarget() {
        submitButton.addTarget(self, action: #selector(submitBtnClicked), for: .touchUpInside)
        textView.delegate = self
    }
    
    fileprivate func showOrHidePlaceHolder() {
        placeholderLabel.isHidden = textView.text.isEmpty
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CommentInputAccessoryView:UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        showOrHidePlaceHolder()
    }
}

extension CommentInputAccessoryView {
    fileprivate func setupUI() {
        placeholderLabel = UILabel.create(text: "Enter Comment", textAlignment: .left, textColor: .lightGray, fontSize: 15, boldFont: false, numberofLine: 1)
        
        textView = UITextView.create(text: "", mainFontSize: 18, customFont: nil, textColor: .black, backgroundColor: .clear, textAlignment: .left, isEditable: false, isScrollEnabled: false, attributedText: nil)
        
        submitButton = UIButton.create(title: "Submit", titleColor: .white, fontSize: 14, backgroundColor: .mainBlue)
        
        let separatorLine = UIView.create(withColor: .mainGray)
        
        textView.addSubview(placeholderLabel)
        
        let group:[UIView] = [textView, submitButton, separatorLine]
        group.forEach(self.addSubview(_:))
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
        }
        
        textView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(8)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-8)
            make.right.equalTo(submitButton.snp.left)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.sizeEqualTo(width: 50, height: 50)
        }
        
        
        
        
        
        
        
        
        
    }
}
