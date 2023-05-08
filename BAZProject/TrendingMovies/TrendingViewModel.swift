//
//  TrendingModel.swift
//  BAZProject
//
//  Created by Manuel S on 28/03/23.
//

import Foundation

final class TrendingViewModel: TrendingListProtocol {
    
    var movies = Box(value: [InfoMoviesProtocol]())
    private var movieAPI: MovieAPI
    
    init(remote: MovieAPI = MovieAPI()) {
        self.movieAPI = remote
    }
    ///se consulta el servicio para lista de peliculas
    func getmovies(category: CategoriesFilter) {
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
    /// Regresa el path para la consulta de la imagen
    func getPathImage(index: Int) -> String? {
        movies.value[index].poster_path
    }
    /// Regresa la informacion de una pelucula
    func getAllInfoMoview(index: Int) -> InfoMoviesProtocol {
        movies.value[index]
    }
}
