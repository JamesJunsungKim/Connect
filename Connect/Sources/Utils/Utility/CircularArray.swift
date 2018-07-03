//
//  CircularArraty.swift
//  Connect
//
//  Created by James Kim on 6/30/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation


public struct CircularArray<T> {
    /**
     This array behaves like a normal array but this has a limit. if it goes over the limit, it will eliminate the oldest one and insert it at that spot.
     */
    
    // MARK: - Public
    public init(size: Int, initialElements:[T] = []) {
        assert(size > 0 , "size must be bigger than 0")
        assert(initialElements.count <= size)
        maximumIndex = size-1
        elements = initialElements
    }
    
    public mutating func clear() {
        elements.removeAll()
        indexForOldestElement = 0
    }
    
    public var content: [T] {
        return elements
    }
    
    public mutating func add(_ element: T) {
        if elements.count-1 != maximumIndex {
            elements.append(element)
        } else {
            elements.replace(element: element, atIndex: indexForOldestElement)
            indexForOldestElement = indexForOldestElement != maximumIndex ? indexForOldestElement+1 : 0
        }
    }
    
    subscript(index: Int) ->T {
        guard index <= maximumIndex else {fatalError()}
        return elements[index]
    }
    
    
    // MARK: - Fileprivate
    fileprivate var indexForOldestElement = 0
    fileprivate let maximumIndex: Int
    fileprivate var elements: [T]
}

