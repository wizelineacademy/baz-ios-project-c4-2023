//
//  StringExtensions.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 04/04/23.
//

import Foundation

extension String {

    /**
     Convierte una cadena de texto en una instancia de `URL`.
     - Returns: Una instancia de `URL` creada a partir de la cadena de texto.
     */
    func toUrl() -> URL {
        guard let url = URL(string: self) else {
            fatalError("La cadena no es una URL válida \(self).")
        }
        return url
    }

    /**
     Obtiene el valor del archivo Lozalizable.strings
     - Returns: Un valor de base al nombre mapeado
     */
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    /**
     Da formato al string recibido con la estructura de yyyy-MM-dd p/e 2019-12-04
     - Returns: Un string con formato de fecha legible  p/e: 04/12/2019
     */
    func formatReleaseDate() -> String {
        let split = self.split(separator: "-")
        return "\(split[2])/\(split[1])/\(split[0])"
    }

    /**
     Remplaza un caracter o palabra y le da formato para ser usado en una url
     - Returns: String
     */
    func setParameters(old: String, new: String) -> String {
        let allowedChars = CharacterSet.urlQueryAllowed
        guard let encode = self.replacingOccurrences(of: old, with: new).addingPercentEncoding(withAllowedCharacters: allowedChars) else {
            fatalError("La cadena no es válida.")
        }
        return encode
    }
}
