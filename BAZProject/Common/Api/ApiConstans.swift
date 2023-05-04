//
//  ApiConstans.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 19/04/23.
//

import Foundation
///Estructura que contiene EndPoints y URls del Api de MovieDB
struct ApiConstans {
    static var baseURL = "https://api.themoviedb.org/3/"
    static var trending = "trending/movie/day"
    static var apiKey = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static var baseUrlImage = "https://image.tmdb.org/t/p/w500"
    static var search = "search/movie"
}
///Tipos de errores para el consumo del Api MovieDB
public enum ApiError: Error {
    ///Error generico del Api
    case defaultError
    /**
     Descripcion del error del Api Movie DB
     - Returns: Regresa un 'String' con la descripcion del error provocado
     */
    var localizedDescription: String {
        switch self {
        case .defaultError:
            return "Error por defecto"
        }
    }
}
