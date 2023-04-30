//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//

import Foundation

class SearchViewModel {
    
    private var service: Service
    
    init(service: Service = ServiceAPI(session: URLSession.shared)) {
        self.service = service
    }
    
    //MARK: - Funciones para la vista
    var moviesSearched = Box(value: [InfoMoviesProtocol]())
    
    ///Crear bind que llama al listener
    func bindMovies(_ listener: @escaping () -> Void) {
        moviesSearched.listener = listener
    }
    
    ///regresa el contador del arreglo de peliculas
    func getMovieCount() -> Int {
        moviesSearched.value.count
    }
    
    ///regresa el campo titulo de la pelicula
    func getTitle(index: Int) -> String? {
        moviesSearched.value[index].title
    }
    
    ///Limpia el arreglo para otra consulta
    func cleanMoviesArray(){
        moviesSearched.value = []
    }
    
    //MARK: - Consulta servicio buscar peliculas
    
    ///se consulta el servicio para lista de peliculas
    func searchMovie(_ title: String, apiKey: String = urls.apikey.rawValue, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "\(categoriesFilter.Search.url)\(apiKey)&query=\(title.formatterMovieName())") else { return }
        service.get(url) { [weak self] (result: Result<Movies, Error>) in //service result 
            switch result {
            case .success(let apiResults): self?.moviesSearched.value = apiResults.results ?? []
            case .failure(let error): completion(error)
            }
        }
    }
}
