//
//  String+.swift
//  BAZProject
//
//  Created by Manuel S on 05/05/23.
//

import Foundation

// Metodos extras para el uso de peliculas con Strings
extension String {
    
    /// Formato del nombre de la pelicula para poder buscarla
    func formatterMovieName() -> String {
        self.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil) //Dividir palabras para la busqueda
    }
}
