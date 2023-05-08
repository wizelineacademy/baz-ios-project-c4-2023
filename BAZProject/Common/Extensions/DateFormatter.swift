//
//  DateFormatter.swift
//  BAZProject
//
//  Created by gescarcega on 01/05/23.
//

import Foundation

extension DateFormatter {
    
    static var common: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter
    }
    
}
