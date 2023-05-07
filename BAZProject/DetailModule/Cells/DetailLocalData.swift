//
//  DetailLocalData.swift
//  BAZProject
//
//  Created by gescarcega on 07/05/23.
//

import Foundation

class DetailLocalData {
    
    private var userDefaultsManager: UserDefaultsProtocol!
    
    init(userDefaultsManager: UserDefaultsProtocol = UserDefaults.standard) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func save(data: Data, key: String) {
        userDefaultsManager.save(data, forKey: key)
    }
    
    func getItem(for key: String) -> Data? {
        return userDefaultsManager.getData(forKey: key)
    }
    
}
