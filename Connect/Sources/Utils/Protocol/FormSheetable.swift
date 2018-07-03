//
//  FormSheetable.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

protocol FormSheetable:AnyObject {
    var preferredSize: CGSize {get}
    func setup(fromVC: UIViewController, userInfo: [String:Any]?)
}

extension FormSheetable {
    func setup(fromVC: UIViewController, userInfo: [String:Any]?) {}
}


