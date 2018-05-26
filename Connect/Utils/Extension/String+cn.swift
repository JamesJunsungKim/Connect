//
//  String.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit


extension String {
    
    public func removingCharacters(in string: String) -> String {
        var chars = Substring(self)
        let convertSet = CharacterSet(charactersIn: string)
        for idx in chars.indices.reversed() {
            if convertSet.contains(String(chars[idx]).unicodeScalars.first!) {
                chars.remove(at: idx)
            }
        }
        return String(chars)
    }
    
    public func removingCharacters(in set: CharacterSet) -> String {
        var chars = Substring(self)
        for idx in chars.indices.reversed() {
            if set.contains(String(chars[idx]).unicodeScalars.first!) {
                chars.remove(at: idx)
            }
        }
        return String(chars)
    }
    
    public func getWidth() -> CGFloat {
        let txt = UITextField(frame: .zero)
        txt.text = self
        txt.sizeToFit()
        return txt.frame.size.width
    }
    
    public func convertToURL()-> URL {
        guard let url = URL(string: self) else {fatalError("wrong type")}
        return url
    }
    
    public func validateForEmail() -> Bool {
        let arg = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", arg)
        return predicate.evaluate(with: self)
    }
    
    public func validateForNumber() -> Bool {
        let arg = "^[0-9]+(\\.[0-9]+)?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", arg)
        return predicate.evaluate(with: self)
    }
}
