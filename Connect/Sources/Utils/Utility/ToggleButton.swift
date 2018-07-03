//
//  ToggleButton.swift
//  soken
//
//  Created by James Kim on 6/7/18.
//  Copyright © 2018 codium. All rights reserved.
//
import UIKit
import RxSwift

class ToggleButton: UIButton {
    
    init(offColor:UIColor, onColor: UIColor, borderColor: UIColor, onText: String, offText:String, onTextColor: UIColor, offTextColor: UIColor, fontSize:CGFloat = 15, boldFont: Bool = true) {
        self.offColor = offColor
        self.onColor = onColor
        self.borderColor = borderColor
        self.onText = onText
        self.offText = offText
        self.onTextColor = onTextColor
        self.offTextColor = offTextColor
        self.fontSize = fontSize
        self.boldFont = boldFont
        super.init(frame: .zero)
        setup()
    }
    
    // MARK: - Public
    fileprivate(set) var isOn = false
    public var observeToggle : Observable<Bool> {
        return toggleSubject.asObservable()
    }
    
    // MARK:- Filepriavte
    fileprivate let offColor: UIColor
    fileprivate let onColor: UIColor
    fileprivate let onText: String
    fileprivate let offText: String
    fileprivate let onTextColor: UIColor
    fileprivate let offTextColor: UIColor
    fileprivate let borderColor: UIColor
    fileprivate let fontSize: CGFloat
    fileprivate let boldFont: Bool
    fileprivate let toggleSubject = PublishSubject<Bool>()
    
    fileprivate lazy var attributes = [
        NSAttributedStringKey.foregroundColor: UIFont.mainFont(size: fontSize, shouldBold: boldFont),
        NSAttributedStringKey.foregroundColor: offTextColor
    ]
    
    fileprivate func setup() {
        setCornerRadious(value: 2)
        setBorder(color: borderColor, width: 1)
        
        let attributedString = NSAttributedString(string: offText, attributes: attributes)
        setAttributedTitle(attributedString, for: .normal)
        backgroundColor = offColor
        
        addTarget(self, action: #selector(activateOrDeactivateButton), for: .touchUpInside)
    }
    
    @objc fileprivate func activateOrDeactivateButton() {
        isOn = !isOn
        toggleSubject.onNext(isOn)
        
        attributes[NSAttributedStringKey.foregroundColor] = isOn ? onTextColor : offTextColor
        let attributedString = NSAttributedString(string: isOn ? onText : offText, attributes: attributes)
        setAttributedTitle(attributedString, for: .normal)
        backgroundColor = isOn ? onColor : offColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
