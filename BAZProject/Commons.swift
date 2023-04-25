//
//  Commons.swift
//  BAZProject
//
//  Created by Manuel S on 25/04/23.
//

import Foundation

// Metodos extras para el uso de peliculas con Strings
extension String {
    func formatterMovieName() -> String {
        self.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil) //Dividir palabras para la busqueda
    }
}

enum urls: String {
    case apikey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
}
