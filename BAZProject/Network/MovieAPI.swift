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
    func getMovies(category: CategoriesFilter , idMovie: Int = 0,  completion: @escaping ([InfoMoviesProtocol], Error?) -> Void){
        
        var urlStruct =  ""
        switch category {
         case .trending:
            urlStruct = "\(CategoriesFilter.trending.url)\(urls.apikey.rawValue)"
        case .nowPlaying:
            urlStruct = "\(CategoriesFilter.nowPlaying.url)\(urls.apikey.rawValue)&language=es&region=MX&page=1"
        case .popular:
            urlStruct = "\(CategoriesFilter.popular.url)\(urls.apikey.rawValue)&language=es&region=MX&page=1"
        case .topRated:
            urlStruct = "\(CategoriesFilter.topRated.url)\(urls.apikey.rawValue)&language=es&region=MX&page=1"
        case .upcoming:
            urlStruct = "\(CategoriesFilter.upcoming.url)\(urls.apikey.rawValue)&language=es&region=MX&page=1"
        case .recommendation:
            urlStruct = "\(CategoriesFilter.recommendation.url)\(idMovie)/recommendations?api_key=\(urls.apikey.rawValue)&language=es"
        case .similar:
            urlStruct = "\(CategoriesFilter.similar.url)\(idMovie)/similar?api_key=\(urls.apikey.rawValue)&language=es"
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
    
    ///Funcion que obtiene el arreglo de actores desde el servicio
    func getCast(idMovie: Int,  completion: @escaping ([CastInfoProtocol], Error?) -> Void) {
        let urlStruct = "\(CategoriesFilter.similar.url)\(idMovie)/credits?api_key=\(urls.apikey.rawValue)&language=es"
        guard let url = URL(string: urlStruct) else { return }
        
        service.get(url) { (result: Result<Casts, Error>) in
            switch result {
            case .success(let apiResults): completion(apiResults.cast ?? [], nil)
            case .failure(let error): completion([], error)
            }
        }
    }
    
    ///Funcion que obtiene el actor desde el servicio
    func getActor(name: String,  completion: @escaping ([Cast], Error?) -> Void) {
        let urlStruct = "\(CategoriesFilter.actor.url)\(urls.apikey.rawValue)&language=es&query=\(name)&page=1"
        guard let url = URL(string: urlStruct) else { return }
        print(url)
        service.get(url) { (result: Result<ActorInfo, Error>) in
            switch result {
            case .success(let apiResults): completion(apiResults.results ?? [Cast()], nil)
            case .failure(let error): completion([Cast()], error)
            }
        }
    }
    
    ///se consulta el servicio para lista de peliculas
    func searchMovie(_ title: String, apiKey: String = urls.apikey.rawValue, completion: @escaping ([InfoMoviesProtocol], Error?) -> Void) {
        guard let url = URL(string: "\(CategoriesFilter.search.url)\(apiKey)&query=\(title.formatterMovieName())") else { return }
        
        service.get(url) { (result: Result<Movies, Error>) in //service result
            switch result {
            case .success(let apiResults): completion(apiResults.results ?? [], nil)
            case .failure(let error): completion([], error)
            }
        }
    }
}
