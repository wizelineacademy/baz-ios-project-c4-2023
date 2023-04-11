//
//  MovieFakes.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 30/03/23.
//

import Foundation

class MovieFakes {
    var trendingMovieDay: Data { getDataFrom("trending_movie_day") }
    
    private func getDataFrom(_ file: String) -> Data {
        guard let path = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else {
            fatalError("No se en encontro el archivo del json especificado!!")
        }
        
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            print("Error al leer la información de \(file).json")
            return Data()
        }
    }
}
