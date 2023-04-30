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
    func getMovies(category: categoriesFilter , idMovie: Int = 0,  completion: @escaping ([InfoMoviesProtocol], Error?) -> Void){
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
        case .Recommendation:
            urlStruct = "\(categoriesFilter.Recommendation.url)\(idMovie)/recommendations?api_key=\(urls.apikey.rawValue)&language=es"
        case .similar:
            urlStruct = "\(categoriesFilter.similar.url)\(idMovie)/similar?api_key=\(urls.apikey.rawValue)&language=es"
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
    
    
    func getCast(idMovie: Int,  completion: @escaping ([CastInfoProtocol], Error?) -> Void) {
        let urlStruct = "\(categoriesFilter.similar.url)\(idMovie)/credits?api_key=\(urls.apikey.rawValue)&language=es"
        guard let url = URL(string: urlStruct) else { return }
        print("- \(url)")
        service.get(url) { (result: Result<Casts, Error>) in
            switch result {
            case .success(let apiResults): completion(apiResults.cast ?? [], nil)
            case .failure(let error): completion([], error)
            }
        }
    }
}


