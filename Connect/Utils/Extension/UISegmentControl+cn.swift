//
//  UISegmentControl+cn.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/22/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    public static func create(withTitles titles: [String], tintColor: UIColor, selectedSegmentIndex: Int = 0) ->UISegmentedControl {
        let sc = UISegmentedControl()
        titles.forEach({sc.insertSegment(withTitle: $0, at: titles.index(of: $0)!, animated: false)})
        sc.tintColor = tintColor
        sc.selectedSegmentIndex = selectedSegmentIndex
        return sc
    }
}
