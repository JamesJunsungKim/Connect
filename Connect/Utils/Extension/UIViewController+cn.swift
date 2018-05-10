//
//  UIViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    
    func createDefaultAlert(with title: String?, message: String?, okAction: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: okAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func presentFormSheet<T:FormSheetable>(targetVC: T, userInfo: [String:Any]?, completion:((T)->())? = nil) {
        guard let target = targetVC as? UIViewController else {fatalError("must be view controller")}
        target.modalPresentationStyle = .formSheet
        target.preferredContentSize = targetVC.preferredSize

        self.present(target, animated: true, completion: nil)
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(targetVC)}
    }
    
    func presentPopOver<T:PopOverable>(targetVC: T, sourceView: UIView, userInfo:[String:Any]?, completion:((T)->())? = nil) {
        guard let target = targetVC as? UIViewController else {fatalError("must be view controller")}
        target.modalPresentationStyle = .popover
        target.preferredContentSize = targetVC.preferredSize
        target.popoverPresentationController?.permittedArrowDirections = targetVC.permittedDirection
        target.popoverPresentationController?.sourceRect = sourceView.bounds
        target.popoverPresentationController?.sourceView = sourceView
        
        present(target, animated: true, completion: nil)
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(targetVC)}
    }
    
    func presentDefault<T:DefaultViewController>(targetVC: T, userInfo:[String:Any]?, completion:((T)->())? = nil) {
        guard let target = targetVC as? UIViewController else {fatalError("must be view controller")}
        present(target, animated: true, completion: nil)
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(targetVC)}
    }
    
    
    // MARK: - Animation
    
    func placeHolderBeginningAnimation(label: UILabel, separatorLine: UIView, leadingMargin: CGFloat, bottomMargin: CGFloat) {
        label.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(leadingMargin)
            make.bottom.equalTo(separatorLine.snp.top).offset(-bottomMargin)
        }
        label.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        label.textColor = UIColor.mainBlue
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func placeHolderEndingAnimation(textField: UITextField, label: UILabel,separatorLine: UIView, leadingMargin: CGFloat, bottomMargin: CGFloat) {
        if textField.text!.isEmpty {
            label.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(leadingMargin)
                make.bottom.equalTo(separatorLine.snp.top).offset(-bottomMargin)
            }
            label.textColor = .lightGray
            label.transform = .identity
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    
    // MARK: - Static funcs
    
    
    
    
}












