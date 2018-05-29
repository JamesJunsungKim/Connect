//
//  UINavigationController+cn.swift
//  Connect
//
//  Created by James Kim on 5/15/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit


extension UINavigationController {
    
    // MARK: - Public
    public func setupVerticalInset(size: CGFloat = -5) {
        navigationBar.setTitleVerticalPositionAdjustment(size, for: .default)
    }
    
    // MARK: - Static
   internal static func createDefaultNavigationController(rootViewController: UIViewController, withLargeTitle flag: Bool = false)->UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.navigationBar.setupToMainBlueTheme(withLargeTitle: flag)
        return nav
    }
}

