//
//  String+Extensions.swift
//  BAZProject
//
//  Created by jmgarciaca on 20/04/23.
//

import Foundation

public extension String {
    
    func urlEncoded() -> String? {
        addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)?
            .replacingOccurrences(of: "&", with: "%26")
    }
}
