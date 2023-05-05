//
//  Box.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//
import Foundation

// MARK: - Box para manejo de MVVM

public struct Box<T> {
    public var value: T {
        didSet {
            listener?()
        }
    }
    var listener: (() -> Void)?
    
    public init(value: T) {
        self.value = value
    }
    
    public mutating func bind(_ listener: @escaping (() -> Void)) {
        self.listener = listener
        self.listener?()
    }
}
