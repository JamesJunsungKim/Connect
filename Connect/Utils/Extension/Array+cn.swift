//
//  Array.swift
//  Connect
//
//  Created by James Kim on 5/6/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

extension Array {
    
    // MARK: - Public
    public mutating func updateItem(atIndex index: Int, WithElement element: Iterator.Element) {
        remove(at: index)
        insert(element, at: index)
    }
    
    public mutating func removeItem(condition:(Iterator.Element)->Bool) {
        var result = [Element]()
        for item in self where !condition(item) {
            result.append(item)
        }
        self = result
    }
    
    public var decomposed:(Iterator.Element, [Iterator.Element])? {
        guard let x = first else {return nil}
        return (x, Array(self[1..<count]))
    }
    
    public func sliced(size: Int) -> [[Iterator.Element]] {
        var result = [[Iterator.Element]]()
        for idx in stride(from: startIndex, to: endIndex, by: size) {
            let end = Swift.min(idx+size, endIndex)
            result.append(Array(self[idx..<end]))
        }
        return result
    }
    
    public func removeElement(condition: (Iterator.Element)->Bool) -> [Element]{
        var result = [Element]()
        for x in self where !condition(x) {
            result.append(x)
        }
        return result
    }
}

extension Array where Iterator.Element: Equatable {
    public mutating func update(element: Element) {
        guard let targetIndex = self.index(of: element) else {assertionFailure(); return}
        remove(at: targetIndex)
        insert(element, at: targetIndex)
    }
}
