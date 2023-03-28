//
//  MovieFakes.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import Foundation

class MovieFakes {
    var movieList: Data { getDataFrom(json: "movieResult") }
    
    // MARK: - Private methods
    private func getDataFrom(json file: String) -> Data {
        guard let path: String = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else {
            fatalError("El archivo seleccionado no se encontró")
        }
        let data: Data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
}
