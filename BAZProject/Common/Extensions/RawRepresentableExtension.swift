//
//  RawRepresentableExtension.swift
//  BAZProject
//
//  Created by gescarcega on 27/04/23.
//

import Foundation

extension RawRepresentable {
    
    public init?(_ optionalRawValue: RawValue?) {
        guard let optionalRawValue = optionalRawValue else { return nil }
        self.init(rawValue: optionalRawValue)
    }
    
}
