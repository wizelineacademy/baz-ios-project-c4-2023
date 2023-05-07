//
//  UserDefaultsMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 07/05/23.
//

import Foundation
@testable import BAZProject

class UserDefaultsMock: UserDefaultsProtocol {
    
    var data: Data?
    
    func save(_ value: Any?, forKey: String) {
        self.data = value as? Data
    }
    
    func getData(forKey: String) -> Data? {
        return data
    }
    
}
