//
//  MovieSave.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 02/05/23.
//

import Foundation

public final class MovieFavorites {
    
    private let userDefaults = UserDefaults.standard
    
    func favorite(_ movieId: Int) {
        
        userDefaults.set(true, forKey: "\(movieId)")
    }
    
    func delete(_ movieId: Int) {
        userDefaults.set(false, forKey: "\(movieId)")
    }
    
    func isSave(movieId: Int) -> Bool{
        userDefaults.bool(forKey: "\(movieId)")
    }
    
}
