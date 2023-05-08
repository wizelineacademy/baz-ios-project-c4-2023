//
//  DateFormatter.swift
//  BAZProject
//
//  Created by gescarcega on 01/05/23.
//

import Foundation

extension DateFormatter {
    
    static func getString(from date: Date?) -> String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter.string(from: date)
    }
    
    static func getDate(from string: String?, format: String = "yyyy-MM-dd") -> Date? {
        guard let string = string else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)
    }
    
}
