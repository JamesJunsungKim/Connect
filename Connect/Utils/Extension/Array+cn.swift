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
    
}

extension Array where Iterator.Element: Equatable {
    public mutating func removeElement(condition: (Iterator.Element)->Bool){
//        var result = [Element]()
//        for x in self where !condition(x) {
//            result.append(x)
//        }
//        return result
        
        self.filter(condition).map({self.index(of: $0)!}).forEach({self.remove(at: $0)})
        
    }
}
