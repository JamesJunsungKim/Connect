//
//  ViewControllerDefault.swift
//  Connect
//
//  Created by James Kim on 5/9/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

protocol DefaultViewController: AnyObject {
    func setup(fromVC: UIViewController, userInfo: [String:Any]?)
}

extension DefaultViewController{
    func setup(fromVC: UIViewController, userInfo: [String:Any]?) {}
}
