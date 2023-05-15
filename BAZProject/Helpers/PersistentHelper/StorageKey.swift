//
//  StorageKey.swift
//  BAZProject
//
//  Created by 989438 on 08/05/23.
//

import Foundation

public struct StorageKey: RawRepresentable {
    
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
