//
//  DetailsViewModel.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import Foundation

final class DetailsViewModel: DetailsProtocol {

    //MARK: - Outlets
    
    var movieDetail: Box<InfoMoviesProtocol>
    var recommendationMovies: Box<[InfoMoviesProtocol]>
    var similarMovies: Box<[InfoMoviesProtocol]>
    var castMovie: Box<[CastInfoProtocol]>
    private var movieAPI: MovieAPI
    let userDefaults = UserDefaults.standard

    init(movieDetail: InfoMoviesProtocol, remote: MovieAPI = MovieAPI() ) {
        self.movieDetail = Box(value: movieDetail)
        self.recommendationMovies = Box(value: [movieDetail])
        self.similarMovies = Box(value: [movieDetail])
        self.castMovie = Box(value: [Cast()])
        self.movieAPI = remote
    }
    ///regresa el campo titulo de la pelicula
    func getTitle() -> String? {
        movieDetail.value.title
    }
    ///Crear bind que llama al listener
    func bindMovie(_ listener: @escaping () -> Void) {
        movieDetail.listener = listener
        castMovie.listener = listener
        similarMovies.listener = listener
        recommendationMovies.listener = listener
    }
    /// Regresa el path para la consulta de la imagen
    func getPathImage() -> String? {
        movieDetail.value.poster_path
    }
    ///regresa la reseña de la  peliculas
    func getOverview() -> String? {
        movieDetail.value.overview
    }
    ///regresa el rankinf de la  peliculas
    func getRating() -> String? {
        "\(movieDetail.value.vote_average ?? 0.0)"
    }
    /// Salva la pelicula en UserDefauls de favoritos
    func saveUserDefautls(key: String) {
        do {
            guard let movie = movieDetail.value as? Movie else { return }
            if let data = UserDefaults.standard.data(forKey: key) {
                var UDData = try JSONDecoder().decode([Movie].self, from: data)
                UDData.append(movie)
                let data = try JSONEncoder().encode(UDData)
                UserDefaults.standard.set(data, forKey: key)
            } else {
                let data = try JSONEncoder().encode([movie])
                UserDefaults.standard.set(data, forKey: key)
            }
        } catch {
            print("Can not store:", error)
        }
        print("se agrego")

    }
    
    /// Elimina la pelicula en UserDefauls de favoritos
    func deteleUserDefautls(key: String) {
        do {
            guard let movie = movieDetail.value as? Movie else { return }
            if let data = UserDefaults.standard.data(forKey: key) {
                var UDData = try JSONDecoder().decode([Movie].self, from: data)
                
                for (index, element) in UDData.enumerated() {
                    if element.id == movie.id {
                        UDData.remove(at: index)
                    }
                }
                let data = try JSONEncoder().encode(UDData)
                UserDefaults.standard.set(data, forKey: key)
            }
        } catch {
            print("Can not store:", error)
        }
        print("se elimino")
    }
    
    /// Indicaror si la pelicula esta en el arreglo de favoritos
    func isMovieFavorite() -> Bool {
        var fav = false
        do {
            guard let movie = movieDetail.value as? Movie else { return  false }
            guard let data = UserDefaults.standard.data(forKey: DefaultsKey.favorites.rawValue) else { return false }
            let UDData = try JSONDecoder().decode([Movie].self, from: data)
            UDData.forEach { Movie in
                if movie.id == Movie.id{
                    fav = true
                }
            }
        } catch {
            print("Can not store:", error)
        }
        return fav
    }
}
//MARK: - Extensiones

//MARK: - recommendation movies services

extension DetailsViewModel {
    
    //Consulta el servicio para obtener los datos
    func getRecommendationMovies() {
        movieAPI.getMovies(category: .recommendation, idMovie: movieDetail.value.id ?? 0) { [weak self] movieArray, _ in
            self?.recommendationMovies.value = movieArray
        }
    }
    
    ///regresa el campo titulo de la pelicula
    func getRecommendationMoviesTitle(index: Int) -> String? {
        recommendationMovies.value[index].title
    }
    ///Regresa el conteo del arreglo de peliculas
    func getRecommendationMoviesCount() -> Int? {
        recommendationMovies.value.count
    }
    /// Regresa el path para la consulta de la imagen
    func getRecommendationPath(index: Int) -> String? {
        recommendationMovies.value[index].poster_path
    }
    /// Regresa la informacion de una pelucula
    func getAllIRecoMovie(index: Int) -> InfoMoviesProtocol {
        recommendationMovies.value[index]
    }
}

//MARK: - Similar movies services

extension DetailsViewModel {
    
    //Consulta el servicio para obtener los datos
    func getSimilarMovies() {
        movieAPI.getMovies(category: .similar, idMovie: movieDetail.value.id ?? 0) { [weak self] movieArray, _ in
            self?.similarMovies.value = movieArray
        }
    }
    
    ///regresa el campo titulo de la pelicula
    func getSimilarMoviesTitle(index: Int) -> String? {
        similarMovies.value[index].title
    }
    ///Regresa el conteo del arreglo de peliculas
    func getSimilarMoviesCount() -> Int? {
        similarMovies.value.count
    }
    /// Regresa el path para la consulta de la imagen
    func getSimilarPath(index: Int) -> String? {
        similarMovies.value[index].poster_path
    }
    /// Regresa la informacion de una pelucula
    func getAllSimilarMovie(index: Int) -> InfoMoviesProtocol {
        similarMovies.value[index]
    }
}

//MARK: - Cast movie services

extension DetailsViewModel {
    //Consulta el servicio para obtener los datos
    func getCastMovie() {
        movieAPI.getCast(idMovie: movieDetail.value.id ?? 0) { [weak self] movieArray, _ in
            self?.castMovie.value = movieArray
        }
    }
    
    ///regresa el campo titulo de la pelicula
    func getCastMovieTitle(index: Int) -> String? {
         castMovie.value[index].name
    }
    ///Regresa el conteo del arreglo de peliculas
    func getCastMovieMoviesCount() -> Int? {
        castMovie.value.count
    }
    ///Regresa el personaje que interpreto el actor
    func getCastMovieMoviesCharacter(index: Int) -> String? {
        castMovie.value[index].character
    }
    
    /// Regresa el path para la consulta de la imagen
    func getCastPath(index: Int) -> String? {
        castMovie.value[index].profile_path
    }
    /// Regresa la informacion de una pelucula
    func getAllActorMovie(index: Int) -> CastInfoProtocol {
        castMovie.value[index]
    }
}
