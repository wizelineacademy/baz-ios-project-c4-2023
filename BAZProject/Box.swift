//
//  Box.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//

import Foundation

struct Box<T> {
    var value: T {
        didSet {
            listener?()
        }
    }
    var listener: (() -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    mutating func bind(_ listener: @escaping (() -> Void)) {
        self.listener = listener
        self.listener?()
    }
}
