//
//  UserDefaults+UserDefaultsProtocol.swift
//  BAZProject
//
//  Created by gescarcega on 07/05/23.
//

import Foundation

protocol UserDefaultsProtocol {
    
    func save(_ value: Any?, forKey: String)
    func getData(forKey: String) -> Data?
    
}

extension UserDefaults: UserDefaultsProtocol {
    
    func save(_ value: Any?, forKey: String) {
        setValue(value, forKey: forKey)
    }
    
    func getData(forKey: String) -> Data? {
        return data(forKey: forKey)
    }
}
