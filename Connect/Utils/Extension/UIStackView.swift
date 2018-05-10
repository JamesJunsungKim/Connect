//
//  UIStackView.swift
//  Connect
//
//  Created by James Kim on 5/10/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

extension UIStackView {
    
    public static func create(views:[UIView], axis:UILayoutConstraintAxis = .horizontal, alignment: UIStackViewAlignment = .center, distribution: UIStackViewDistribution, spacing: CGFloat)-> UIStackView {
        let stv = UIStackView()
        stv.axis = axis
        stv.alignment = alignment
        stv.spacing = spacing
        stv.distribution = distribution
        views.forEach(stv.addArrangedSubview(_:))
        return stv
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
