//
//  PopOverable.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

protocol PopOverable: AnyObject {
    var preferredSize: CGSize{get}
    var permittedDirection: UIPopoverArrowDirection {get}
    func setup(fromVC: UIViewController, userInfo:[String:Any]?)
}

