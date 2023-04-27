//
//  TrendingModel.swift
//  BAZProject
//
//  Created by Manuel S on 28/03/23.
//

import Foundation


final class TrendingViewModel: MoviesListProtocol {
    
    var movies = Box(value: [ListMoviesProtocol]())
    private var movieAPI: MovieAPI
    
    init(remote: MovieAPI = MovieAPI()) {
        self.movieAPI = remote
    }
    ///se consulta el servicio para lista de peliculas
    func getmovies(category: categoriesFilter) {
        movieAPI.getMovies(category: category) { [weak self] moviearray, _ in
            self?.movies.value = moviearray
        }
    }
    ///Crear bind que llama al listener
    func bindMovies(_ listener: @escaping () -> Void) {
        movies.listener = listener
    }
    ///regresa el contador del arreglo de peliculas
    func getMovieCount() -> Int {
        movies.value.count
    }
    ///regresa el campo titulo de la pelicula
    func getTitle(index: Int) -> String? {
        movies.value[index].title
    }
    
    func getPathImage(index: Int) -> String? {
        movies.value[index].poster_path
    }
    
    func getAllInfoMoview(index: Int) -> ListMoviesProtocol {
        movies.value[index]
    }
}
