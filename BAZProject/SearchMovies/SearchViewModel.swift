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
    
    //MARK:Funciones para la vista 
    var moviesSearched = Box(value: [ListMoviesProtocol]())
    
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
    
    //MARK:Consulta servicio buscar peliculas
    
    ///se consulta el servicio para lista de peliculas
    func searchMovie(_ title: String, apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a", completion: @escaping (Error?) -> Void) {
        let editedTitle = title.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil) //Dividir palabras para la busqueda
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(editedTitle)") else { return }
        service.get(url) { [weak self] (result: Result<Movies, Error>) in
        //service result 
            switch result {
            case .success(let apiResults): self?.moviesSearched.value = apiResults.results ?? []
            case .failure(let error): completion(error)
            }
        }
    }
}
