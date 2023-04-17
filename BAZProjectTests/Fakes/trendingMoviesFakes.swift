//
//  trendingMoviesFakes.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 12/04/23.
//

import Foundation


import Foundation

class trendingMoviesFakes {
    var trendingBlock: Data { getDataFrom(json: "trendingMovies") }
    
    // MARK: - Private methods
    private func getDataFrom(json file: String) -> Data {
        guard let path: String = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else {
            fatalError("El archivo seleccionado no se encontró")
        }
        let data: Data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
}
