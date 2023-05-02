//
//  String+Extensions.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//

import Foundation

extension String {
    var firstCapitalized: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
