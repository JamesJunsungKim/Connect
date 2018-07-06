//
//  CommentInputAccessoryView.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/30/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class CommentInputAccessoryView: UIView, NameDescribable {
    // UI
    // first level
    fileprivate var textView: UITextView!
    fileprivate var placeholderLabel: UILabel!
    fileprivate var submitButton: UIButton!
    
    // second level
    fileprivate var cameraButton: UIButton!
    fileprivate var gifButton: UIButton!
    fileprivate var voiceMailButton: UIButton!
    fileprivate var mapButton: UIButton!
    fileprivate var sketchButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupView()
        addTarget()
    }
    
    // MARK: - Public/Internal
    public var textViewObservable: Observable<String> {
        return textSubject.asObservable()
    }
    
    // MARK: - Actions
    @objc fileprivate func submitBtnClicked() {
        textSubject.onNext(textView.text)
        textView.text = nil
        showOrHidePlaceHolder()
    }
    
    @objc fileprivate func camerraBtnClicked() {
        
    }
    
    @objc fileprivate func gifBtnClicked() {
        
    }
    
    @objc fileprivate func mapBtnClicked() {
        
    }
    
    @objc fileprivate func sketchBtnClicked() {
    
    }
    
    @objc fileprivate func voiceBtnClicked() {
        
    }
    
    
    // MARK: - Fileprivate
    fileprivate var textSubject = PublishSubject<String>()
    
    fileprivate func setupView() {
        self.backgroundColor = .white
        autoresizingMask = .flexibleHeight
    }
    
    fileprivate func addTarget() {
        submitButton.addTarget(self, action: #selector(submitBtnClicked), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(camerraBtnClicked), for: .touchUpInside)
        gifButton.addTarget(self, action: #selector(gifBtnClicked), for: .touchUpInside)
        mapButton.addTarget(self, action: #selector(mapBtnClicked), for: .touchUpInside)
        sketchButton.addTarget(self, action: #selector(sketchBtnClicked), for: .touchUpInside)
        voiceMailButton.addTarget(self, action: #selector(voiceBtnClicked), for: .touchUpInside)
    }
    
    fileprivate func showOrHidePlaceHolder() {
        placeholderLabel.isHidden = !textView.text.isEmpty
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
        
        textView = UITextView.create(text: "", mainFontSize: 18, customFont: nil, textColor: .black, backgroundColor: .clear, textAlignment: .left, isEditable: true, isScrollEnabled: false, attributedText: nil)
        textView.delegate = self
        
        submitButton = UIButton.create(title: "Submit", titleColor: .mainBlue, fontSize: 14, backgroundColor: .clear)
        cameraButton = UIButton.create(withImageName: "camera_input")
        gifButton = UIButton.create(withImageName: "gif_input")
        mapButton = UIButton.create(withImageName: "map_input")
        sketchButton = UIButton.create(withImageName: "sketch_input")
        voiceMailButton = UIButton.create(withImageName: "voice_input")
        
        let separatorLineTop = UIView.create(withColor: .lightGray)
        let separatorLineBottom = UIView.create(withColor: .lightGray)
        textView.addSubview(placeholderLabel)
        
        let group:[UIView] = [textView, submitButton, separatorLineTop, cameraButton, gifButton, mapButton, sketchButton, voiceMailButton,separatorLineBottom]
        group.forEach(self.addSubview(_:))
        
        let buttonSizeMaker: (ConstraintMaker) -> Void = { (make)in
            make.sizeEqualTo(width: 50, height: 30)
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(9)
            make.left.equalToSuperview().offset(6)
        }
        
        textView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(8)
            make.bottom.equalTo(separatorLineTop.snp.bottom).offset(-8)
            make.right.equalTo(submitButton.snp.left)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(separatorLineTop.snp.bottom).offset(-14)
            make.right.equalToSuperview().offset(-12)
            buttonSizeMaker(make)
        }
        
        separatorLineTop.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        cameraButton.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineTop.snp.top)
            make.left.equalToSuperview().offset(6)
            buttonSizeMaker(make)
        }
        
        gifButton.snp.makeConstraints { (make) in
            make.top.equalTo(cameraButton)
            make.left.equalTo(cameraButton.snp.right).offset(6)
            buttonSizeMaker(make)
        }
        
        mapButton.snp.makeConstraints { (make) in
            make.top.equalTo(cameraButton)
            make.left.equalTo(gifButton.snp.right).offset(6)
            buttonSizeMaker(make)
        }
        
        sketchButton.snp.makeConstraints { (make) in
            make.top.equalTo(cameraButton)
            make.left.equalTo(mapButton.snp.right).offset(6)
            buttonSizeMaker(make)
        }
        
        voiceMailButton.snp.makeConstraints { (make) in
            make.top.equalTo(cameraButton)
            make.left.equalTo(sketchButton.snp.right).offset(6)
            buttonSizeMaker(make)
        }
    }
}
