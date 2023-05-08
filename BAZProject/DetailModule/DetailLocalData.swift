//
//  DetailLocalData.swift
//  BAZProject
//
//  Created by gescarcega on 07/05/23.
//

import Foundation

class DetailLocalData {
    
    private var userDefaultsManager: UserDefaultsProtocol
    
    init(userDefaultsManager: UserDefaultsProtocol = UserDefaults.standard) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func save(data: Data, key: String) {
        userDefaultsManager.save(data, forKey: key)
    }
    
    func findItem(for key: String) -> Bool {
        return userDefaultsManager.find(key: key)
    }
    
    func deleteItem(for key: String) {
        userDefaultsManager.delete(for: key)
    }
    
}
