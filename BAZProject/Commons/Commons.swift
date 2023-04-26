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


enum categoriesFilter: String {
    case Trending = "Trending"
    case NowPlaying = "Now Playing"
    case Popular = "Popular"
    case TopRated = "Top Rated"
    case Upcoming = "Upcoming"
    case Search =  "Search"
    
    var url: String {
        switch self {
        case .Trending:
            return "https://api.themoviedb.org/3/trending/movie/day?api_key="
        case .NowPlaying:
            return "https://api.themoviedb.org/3/movie/now_playing?api_key="
        case .Popular:
            return "https://api.themoviedb.org/3/movie/popular?api_key="
        case .TopRated:
            return "https://api.themoviedb.org/3/movie/top_rated?api_key="
        case .Upcoming:
            return "https://api.themoviedb.org/3/movie/upcoming?api_key="
        case .Search:
            return "https://api.themoviedb.org/3/search/movie?api_key="
        }
    }
}

//MARK: - Extensiones

// Metodos extras para el uso de peliculas con Strings
extension String {
    func formatterMovieName() -> String {
        self.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil) //Dividir palabras para la busqueda
        
    }
}

extension UIImageView{
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
