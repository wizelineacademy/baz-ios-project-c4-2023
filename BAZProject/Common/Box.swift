//
//  Box.swift
//  BAZProject
//
//  Created by gescarcega on 18/04/23.
//

import Foundation

struct Box<T> {
    
    private var listener: ((T) -> Void)?

    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    mutating func bind(_ listener: @escaping ((T) -> Void)) {
        self.listener = listener
        self.listener?(value)
    }
    
}
