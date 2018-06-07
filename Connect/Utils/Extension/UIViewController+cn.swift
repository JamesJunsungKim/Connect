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
import ARSLineProgress

extension UIViewController {
    
    // MARK: - Alert & Error
    func presentDefaultAlertWithoutCancel(withTitle title: String, message: String?, okAction: (block)? = nil) {
        let pop = PopupDialog(title: title, message: message)
        let okBtn = PopupDialogButton(title: "Ok", action: {if okAction != nil {okAction!()}})
        
        pop.addButton(okBtn)
        present(pop, animated: true, completion: nil)
    }
    
    func presentDefaultAlert(withTitle title: String?, message: String?, okAction: (block)? = nil, cancelAction: (block)? = nil) {
        let pop = PopupDialog(title: title, message: message)
        let cancelBtn = PopupDialogButton(title: "Cancel") {
            if cancelAction != nil {cancelAction!()}}
        let okBtn = PopupDialogButton(title: "Ok", action: {if okAction != nil {okAction!()}})
        
        pop.addButtons([okBtn, cancelBtn])
        present(pop, animated: true, completion: nil)
    }
    
    func presentDefaultError(message: String = "Something went wrong.. \nPlease try it again" ,okAction: (block)? = nil) {
        let pop = PopupDialog(title: "Error", message: message)
        let okBtn = PopupDialogButton(title: "Ok") {if okAction != nil {okAction!()}}
        pop.addButton(okBtn)
        present(pop, animated: true, completion: nil)
    }
    
    // MARK: - ARSLine
    func presentARSLineProgress() {
        ARSLineProgress.ars_showOnView(view)
    }
    
    func presentARSLineSuccess(block:@escaping block) {
        ARSLineProgress.showSuccess(andThen: block)
    }
    
    // MARK: - Action Sheet
    
    func presentActionSheetWithCancel(title: String?, message: String?, firstTitle: String?, firstAction: (block)?, cancelAction: (block)? = nil, configuration: ((UIAlertController)->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: firstTitle, style: .default) { (_) in
            firstAction?()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            cancelAction?()
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        alertController.addAction(firstAction)
        configuration?(alertController)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
   
    // MARK: - Segue
    
    func presentFormSheetVC<T:FormSheetViewController>(targetVC: T, userInfo: [String:Any]?, completion:((T)->())? = nil) {
        targetVC.modalPresentationStyle = .formSheet
        targetVC.preferredContentSize = targetVC.preferredSize

        self.present(targetVC, animated: true, completion: nil)
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(targetVC)}
    }
    
    func presentPopOverVC<T:PopOverViewController>(targetVC: T, sourceView: UIView, userInfo:[String:Any]?, completion:((T)->())? = nil) {
        targetVC.modalPresentationStyle = .popover
        targetVC.preferredContentSize = targetVC.preferredSize
        targetVC.popoverPresentationController?.permittedArrowDirections = targetVC.permittedDirection
        targetVC.popoverPresentationController?.sourceRect = sourceView.bounds
        targetVC.popoverPresentationController?.sourceView = sourceView
        
        present(targetVC, animated: true, completion: nil)
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(targetVC)}
    }
    
    func presentDefaultVC<T:DefaultViewController>(targetVC: T, userInfo:[String:Any]?,shouldPushOnNavigationController:Bool = true, completion:((T)->())? = nil) {
        let _ = targetVC
        
        shouldPushOnNavigationController ? navigationController?.pushViewController(targetVC, animated: true) : self.present(targetVC, animated: true, completion: nil)
        
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(targetVC)}
    }
    
    func presentImagePicker(pickerDelegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate), sourceType: UIImagePickerControllerSourceType = .photoLibrary) {
        let imagePicker = UIImagePickerController()
        imagePicker.navigationBar.setupToMainBlueTheme(withLargeTitle: false)
        imagePicker.delegate = pickerDelegate
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    public func presentMasterAlbumViewController(photoSelectAction: @escaping ((UIImage)->())) {
        let destination = MasterAlbumViewController(photoSelectAction: photoSelectAction)
        let nav = UINavigationController(rootViewController: destination)
        nav.navigationBar.setupToMainBlueTheme(withLargeTitle: false)
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - Animation
    
    func placeHolderBeginningAnimation(label: UILabel, bottomView: UIView, leadingMargin: CGFloat, bottomMargin: CGFloat) {
        label.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(leadingMargin)
            make.bottom.equalTo(bottomView.snp.top).offset(-bottomMargin)
        }
        label.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        label.textColor = UIColor.mainBlue
        
        UIView.animate(withDuration: 0.5) {
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
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Helpers
    
    func getHeightOfNavigationBarAndStatusBar() -> CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    
    
    // MARK: - Static funcs
    
    
    
    
}












