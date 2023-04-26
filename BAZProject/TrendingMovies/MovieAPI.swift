//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {
    
    private var service: Service
    
    init(service: Service = ServiceAPI(session: URLSession.shared)) {
        self.service = service
    }
    ///Función generica que consulta las  de peliculas de acuerdo a la categoria
    func getMovies(category: categoriesFilter , completion: @escaping ([ListMoviesProtocol], Error?) -> Void){
        var urlStruct =  ""
        switch category {
         case .Trending:
            urlStruct = "\(categoriesFilter.Trending.url)\(urls.apikey.rawValue)"
        case .NowPlaying:
            urlStruct = "\(categoriesFilter.NowPlaying.url)\(urls.apikey.rawValue)&language=es&region=MX&page=1"
        case .Popular:
            urlStruct = "\(categoriesFilter.Popular.url)\(urls.apikey.rawValue)&language=es&region=MX&page=1"
        case .TopRated:
            urlStruct = "\(categoriesFilter.TopRated.url)\(urls.apikey.rawValue)&language=es&region=MX&page=1"
        case .Upcoming:
            urlStruct = "\(categoriesFilter.Upcoming.url)\(urls.apikey.rawValue)&language=es&region=MX&page=1"
        default:
            urlStruct = ""
        }
        
        guard let url = URL(string: urlStruct) else { return }
        service.get(url) { (result: Result<Movies , Error>) in
            switch result {
            case .success(let apiResults): completion(apiResults.results ?? [], nil)
            case .failure(let error): completion([], error)
            }
        }
    }
}
