//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//

import Foundation

class SearchViewModel: SearchListProtocol {
    
    private var service: Service
    private var movieAPI: MovieAPI
    
    init(service: Service = ServiceAPI(session: URLSession.shared), remote: MovieAPI = MovieAPI()) {
        self.service = service
        self.movieAPI = remote
    }
    
    // MARK: - Funciones para la vista
    
    ///Varible donde se almacenara informacion de las peliculas
    var moviesSearched = Box(value: [InfoMoviesProtocol]())
    
    /// Variable para almacenar los actores
    var actorSearched = Box(value: [Cast]())
    
    ///Crear bind que llama al listener
    func bindMovies(_ listener: @escaping () -> Void) {
        moviesSearched.listener = listener
        actorSearched.listener = listener
    }
    
    ///regresa el contador del arreglo de peliculas
    func getMovieCount() -> Int {
        moviesSearched.value.count
    }
    
    ///regresa el campo titulo de la pelicula
    func getTitle(index: Int) -> String? {
        moviesSearched.value[index].title
    }
    
    ///regresa el campo del path para la imagen de la pelicula
    func getImagePath(index: Int) -> String? {
        moviesSearched.value[index].poster_path
    }
    
    ///Limpia el arreglo para otra consulta
    func cleanMoviesArray() {
        moviesSearched.value = []
        actorSearched.value = []
    }
    
    ///Funcion que devolvera la informacion de una pelicula
    func getAllInfoMoview(index: Int) -> InfoMoviesProtocol {
        moviesSearched.value[index]
    }
    
    /// regresa el nombre del actor
    func getActorName(index: Int) -> String? {
        actorSearched.value[index].name
    }
    
    /// regresa el contador del arreglo
    func getActorsArray() -> Int {
        actorSearched.value.count
    }
    
    ///regresa el campo del path para la imagen de la pelicula
    func getPhotoPath(index: Int) -> String? {
        actorSearched.value[index].profile_path
    }
    
    /// funcion que busca las peliculas
    func searchMovie(title: String) {
        movieAPI.searchMovie(title) { [weak self] movieArray, _ in
            self?.moviesSearched.value = movieArray
        }
    }

    /// funcion que busca al actor 
    func searchActor(name: String) {
        movieAPI.getActor(name: name.formatterMovieName()) { [weak self] movieArray, _ in
            self?.actorSearched.value = movieArray
        }
    }
}
