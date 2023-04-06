//
//  StringExtensions.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 04/04/23.
//

import Foundation

extension String {
    /// Convierte una cadena de texto en una instancia de `URL`.
    /// 
    ///- Parameters:
    ///  - Returns: Una instancia de `URL` creada a partir de la cadena de texto.
    func toUrl() -> URL {
        guard let url = URL(string: self) else {
            fatalError("La cadena no es una URL válida.")
        }
        return url
    }
}
