//
//  Box.swift
//  BAZProject
//
//  Created by gescarcega on 18/04/23.
//

import Foundation

struct Box<T> {
    private var listener: (() -> Void)?
    
    var value: T {
        didSet {
            listener?()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    mutating func bind(_ listener: @escaping (() -> Void)) {
        self.listener = listener
        self.listener?()
    }
}
