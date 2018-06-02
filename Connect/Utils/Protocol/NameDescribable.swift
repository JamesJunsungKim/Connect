//
//  NameDescribable.swift
//  Connect
//
//  Created by James Kim on 5/31/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

protocol NameDescribable {}

extension NameDescribable {
    static var staticClassName: String {
        return String(describing: self)
    }
    
    public var className: String {
        return String(describing: Self.self)
    }
    
    public func observerDisposedDescription() {
        logInfo("observer is disposed from: \(className)")
    }
}
