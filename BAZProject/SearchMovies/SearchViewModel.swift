//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//

import Foundation

class SearchViewModel {
    
    //MARK:Funciones para la vista 

    var moviesSearched = Box(value: [ListMoviesProtocol]())
    
    func bindMovies(_ listener: @escaping () -> Void) {
        moviesSearched.listener = listener
    }
    
    func getMovieCount() -> Int {
        moviesSearched.value.count
    }
    
    func getTitle(index: Int) -> String? {
        moviesSearched.value[index].title
    }
    
    func cleanMoviesArray(){
        moviesSearched.value = []
    }
    
    //MARK:Consulta servicio buscar peliculas
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a" // llave para peticion de peliculas

    func searchMovie(_ title: String, completion: @escaping (Error) -> Void ) {
        let editedTitle = title.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil) //Dividir palabras para la busqueda
        print(editedTitle)
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(editedTitle)") else { return }
        let service = ServiceAPI(session: URLSession.shared)
        service.get(url) { [weak self] (result: Result<Movies, Error>) in
        //service result 
            switch result {
            case .success(let apiResults): self?.moviesSearched.value = apiResults.results ?? []
            case .failure(let error): completion(error)
            }
        }
    }
    
}
