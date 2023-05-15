//
//  UserDefaultFake.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 13/05/23.
//

import Foundation

@testable import BAZProject

class UserDefaultsFake: UserDefaultsProtocol {
    
    var fakeMoview: [Int : Movie]?
    
    init(fakeMoview: [Int : Movie]?){
        self.fakeMoview = fakeMoview
    }
    
    func data(forKey defaultName: String) -> Data? {
        return Data()
    }
    
    func returnMoviesDictionary() -> [Int : BAZProject.Movie]? {
        return fakeMoview
    }
    
    func setValue(_ value: Any?, forKey key: String) {
        guard let movie = value as? Movie,
              let iKey = Int(key) else { return }
        fakeMoview = [iKey : movie]
    }
    
}
