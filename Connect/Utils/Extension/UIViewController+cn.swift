//
//  UIViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit
import PopupDialog

extension UIViewController {
    
    // MARK: - Alert & Error
    
    func presentDefaultAlert(withTitle title: String?, message: String?, okAction: (()->())? = nil, cancelAction: (()->())? = nil) {
        let pop = PopupDialog(title: title, message: message)
        let cancelBtn = PopupDialogButton(title: "Cancel") {
            if cancelAction != nil {cancelAction!()}}
        let okBtn = PopupDialogButton(title: "Ok", action: {if okAction != nil {okAction!()}})
        
        pop.addButtons([okBtn, cancelBtn])
        present(pop, animated: true, completion: nil)
    }
    
    func presentDefaultError(okAction: (()->())? = nil) {
        let pop = PopupDialog(title: "Error", message: "Something went wrong.. \nPlease try it again")
        let okBtn = PopupDialogButton(title: "Ok") {if okAction != nil {okAction!()}}
        pop.addButton(okBtn)
        present(pop, animated: true, completion: nil)
    }
   
    // MARK: - Segue
    
    func presentFormSheetVC<T:FormSheetable>(targetVC: T, userInfo: [String:Any]?, completion:((T)->())? = nil) {
        guard let target = targetVC as? UIViewController else {fatalError("must be view controller")}
        target.modalPresentationStyle = .formSheet
        target.preferredContentSize = targetVC.preferredSize

        self.present(target, animated: true, completion: nil)
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(targetVC)}
    }
    
    func presentPopOverVC<T:PopOverable>(targetVC: T, sourceView: UIView, userInfo:[String:Any]?, completion:((T)->())? = nil) {
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
    
    func presentDefaultVC<T:DefaultViewController>(targetVC: T, userInfo:[String:Any]?, completion:((T)->())? = nil) {
        guard let target = targetVC as? UIViewController else {fatalError("must be view controller")}
        self.navigationController != nil ? navigationController?.pushViewController(target, animated: true) : self.present(target, animated: true, completion: nil)
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(targetVC)}
    }
    
    func presentImagePicker(pickerDelegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate), sourceType: UIImagePickerControllerSourceType = .photoLibrary) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = pickerDelegate
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Animation
    
    func placeHolderBeginningAnimation(label: UILabel, bottomView: UIView, leadingMargin: CGFloat, bottomMargin: CGFloat) {
        label.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(leadingMargin)
            make.bottom.equalTo(bottomView.snp.top).offset(-bottomMargin)
        }
        label.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        label.textColor = UIColor.mainBlue
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func placeHolderEndingAnimation(textField: UITextField, label: UILabel,bottomView: UIView, leadingMargin: CGFloat, bottomMargin: CGFloat) {
        if textField.text!.isEmpty {
            label.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(leadingMargin)
                make.bottom.equalTo(bottomView.snp.top).offset(-bottomMargin)
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











