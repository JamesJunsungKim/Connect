//
//  UIViewController.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createDefaultAlert(with title: String?, message: String?, okAction: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: okAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func presentFormSheet(targetVC: FormSheetable, userInfo: [String:Any]?, completion:((UIViewController)->())? = nil) {
        guard let target = targetVC as? UIViewController else {fatalError("must be view controller")}
        target.modalPresentationStyle = .formSheet
        target.preferredContentSize = targetVC.preferredSize

        self.present(target, animated: true, completion: nil)
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(target)}
    }
    
    func presentPopOver(targetVC: PopOverable, sourceView: UIView, userInfo:[String:Any]?, completion:((UIViewController)->())? = nil) {
        guard let target = targetVC as? UIViewController else {fatalError("must be view controller")}
        target.modalPresentationStyle = .popover
        target.preferredContentSize = targetVC.preferredSize
        target.popoverPresentationController?.permittedArrowDirections = targetVC.permittedDirection
        target.popoverPresentationController?.sourceRect = sourceView.bounds
        target.popoverPresentationController?.sourceView = sourceView
        
        present(target, animated: true, completion: nil)
        targetVC.setup(fromVC: self, userInfo: userInfo)
        if completion != nil {completion!(target)}
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}












