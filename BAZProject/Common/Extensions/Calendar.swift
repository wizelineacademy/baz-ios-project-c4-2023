//
//  Calendar.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import Foundation

extension Calendar {
    
    static func getString(component: Component, from date: Date?) -> String? {
        guard let date = date else { return nil }
        return String(Calendar.current.component(component, from: date))
        
    }
    
}
