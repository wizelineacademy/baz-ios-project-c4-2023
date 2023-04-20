//
//  TrendingModel.swift
//  BAZProject
//
//  Created by Manuel S on 28/03/23.
//

import Foundation


class TrendingViewModel: MoviesListProtocol {
   
    var movies = Box(value: [ListMoviesProtocol]())
    
    ///se consulta el servicio para lista de peliculas
    func getmovies() {
        let movieApi = MovieAPI()
        movieApi.getMovies { [weak self] moviearray in
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
    
}
