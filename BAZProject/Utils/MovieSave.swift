//
//  MovieSave.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 02/05/23.
//

import Foundation

public final class MovieFavorites {
    
    private let userDefaults = UserDefaults.standard
    
    /// Función para agregar a favoritos
    /// - Parameter movieId: movieId
    func favorite(_ movieId: Int) {
        userDefaults.set(true, forKey: "\(movieId)")
    }
    
    /// Función para eliminar de favoritos.
    /// - Parameter movieId: movieId
    func delete(_ movieId: Int) {
        userDefaults.set(false, forKey: "\(movieId)")
    }
    
    /// Función para verificar si esta añadido en favoritos.
    /// - Parameter movieId: movieId
    /// - Returns: True/False
    func isSave(movieId: Int) -> Bool{
        userDefaults.bool(forKey: "\(movieId)")
    }
    
}
