//
//  ApiConstans.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 19/04/23.
//

import Foundation
///Estructura que contiene EndPoints y URls del Api de MovieDB
protocol ApiPathProtocol{
    var pathBase: String { get }
    var imagePathBase: String { get }
    var apiKey: String { get }
    var endPoint: String { get }
    var urlRequest: URLRequest? { get }
    var imageUrl: URL? { get }
}

extension ApiPathProtocol{
    var imagePathBase: String{
        return "https://image.tmdb.org/t/p/w500"
    }
    var pathBase: String{
        return "https://api.themoviedb.org/3/"
    }
    var apiKey: String{
        return "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es"
    }
}
/// Enum con los diferentes elementos del detalle de una pelicula
enum MovieDetailInfo: ApiPathProtocol {
    case credits(String)
    case similar(String)
    case recomended(String)
    case search(String)
    case image(String)
    case reviews(String)
    
    /// Variable que retorna los endpoints del detalle de una pelicula
    /// - returns:
    ///     - String con el endPointArmado
    var endPoint: String{
        switch self {
        case .credits(let id):
            return "movie/\(id)/credits"
        case .similar(let id):
            return "movie/\(id)/similar"
        case .recomended(let id):
            return "movie/\(id)/recommendations"
        case .reviews(let id):
            return "movie/\(id)/reviews"
        case .search(let searchString):
            let cleanString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "&query=\(cleanString)"
        case .image(let id):
            return id
        
        }
    }
    /// Variable que retorna un URLRequest con el endpoint armado
    /// - returns:
    ///     - URLRequest del elemento del detalle
    var urlRequest: URLRequest?{
        switch self {
        case .search:
            let urlString = self.pathBase + "search/movie" + self.apiKey + self.endPoint
            guard let url = URL(string: urlString) else { return nil }
            return URLRequest(url: url)
        case .image:
            return nil
        default:
            let urlString = self.pathBase + self.endPoint + self.apiKey
            guard let url = URL(string: urlString) else { return nil }
            return URLRequest(url: url)
        }
        
    }
    /// Variable que retorna un URL de una imagen
    /// - returns:
    ///     - URL del elemento del detalle
    var imageUrl: URL?{
        let urlString = self.imagePathBase + self.endPoint
        return URL(string: urlString)
    }
    
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
