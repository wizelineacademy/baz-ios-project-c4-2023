//
//  Commons.swift
//  BAZProject
//
//  Created by Manuel S on 25/04/23.
//

import UIKit


/// enumerador para menejar las ulrs del proyecto
enum urls: String {
    case apikey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
}

/// enumerador para menejar de los tipos y sus urls
enum categoriesFilter: String {
    case Trending = "Trending"
    case NowPlaying = "Now Playing"
    case Popular = "Popular"
    case TopRated = "Top Rated"
    case Upcoming = "Upcoming"
    case Search =  "Search"
    case Recommendation = "Recommendation Movies"
    case similar = "similar Movies"
    case cast = "cast"
    
    var url: String {
        let baseURL = "https://api.themoviedb.org/3/movie/"
        switch self {
        case .Trending:
            return "https://api.themoviedb.org/3/trending/movie/day?api_key="
        case .NowPlaying:
            return "\(baseURL)now_playing?api_key="
        case .Popular:
            return "\(baseURL)popular?api_key="
        case .TopRated:
            return "\(baseURL)top_rated?api_key="
        case .Upcoming:
            return "\(baseURL)upcoming?api_key="
        case .Search:
            return "https://api.themoviedb.org/3/search/movie?api_key="
        case .Recommendation, .similar, .cast:
            return baseURL
        }
    }
}

//enum para UserDefauls
enum UserDKeys: String {
    case favorites = "favoritesMovies"
    case favoriteTests = "favoriteTests"
}

//enum para Manejo de titulos
enum StringsTitles: String {
    case favorites = "Favoritos"
    case search = "buscar"
    case treding = "Trending"
}
//MARK: - Extensiones

// Metodos extras para el uso de peliculas con Strings
extension String {
    /// Formato del nombre de la pelicula para poder buscarla
    func formatterMovieName() -> String {
        self.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil) //Dividir palabras para la busqueda
    }
}

// Metodos extras para la colocacion de las imagenes
extension UIImageView{
    /// Consulta desde una url para colocar la imagen
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url){[weak self] url, response, error in
            guard let self = self else { return }
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
