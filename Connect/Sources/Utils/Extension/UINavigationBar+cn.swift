//
//  UINavigationBar+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/12/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UINavigationBar {
    public func setupToMainBlueTheme(withLargeTitle flag: Bool) {
        barStyle = .black
        barTintColor = UIColor.eateryBlue.navigationBarAdjusted
        tintColor = .white
        titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        if flag {
            if #available(iOS 11.0, *) {
                prefersLargeTitles = true
            }
        } else {
            prefersLargeTitles = false
        }
    }
    
}


