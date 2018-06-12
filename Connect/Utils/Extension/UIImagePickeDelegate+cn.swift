//
//  UIImagePickeDelegate+cn.swift
//  Connect
//
//  Created by James Kim on 5/12/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIImagePickerControllerDelegate {
    func unwrapEditImageOrOriginal(fromInfo info: [String:Any]) -> UIImage? {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            return image
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            return image
        }
        return nil
    }
}
