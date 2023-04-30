//
//  DetailsViewModel.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import Foundation

class DetailsViewModel: DetailsProtocol {
    
    //MARK: - Outlets
    var movie: InfoMoviesProtocol
    var movieDetail: Box<InfoMoviesProtocol>
    var recommendationMovies: Box<[InfoMoviesProtocol]>
    var similarMovies: Box<[InfoMoviesProtocol]>
    var castMovie: Box<[CastInfoProtocol]>
    var favoriteMoviesArray: [InfoMoviesProtocol]
    private var movieAPI: MovieAPI
    
    let userDefaults = UserDefaults.standard

    init(movieDetail: InfoMoviesProtocol, remote: MovieAPI = MovieAPI() ) {
        self.movieDetail = Box(value: movieDetail)
        self.movie = movieDetail
        self.recommendationMovies = Box(value: [movieDetail])
        self.similarMovies = Box(value: [movieDetail])
        self.castMovie = Box(value: [Cast()])
        self.movieAPI = remote
        self.favoriteMoviesArray = userDefaults.object(forKey: UserDKeys.favorites.rawValue) as? [InfoMoviesProtocol] ?? []
    }
    
    func getTitle() -> String? {
        movieDetail.value.title
    }
    
    func bindMovie(_ listener: @escaping () -> Void) {
        movieDetail.listener = listener
        castMovie.listener = listener
        similarMovies.listener = listener
        recommendationMovies.listener = listener
    }
    
    func getPathImage() -> String? {
        movieDetail.value.poster_path
    }
    
    func getOverview() -> String? {
        movieDetail.value.overview
    }
    
    func getRating() -> String? {
        "\(movieDetail.value.vote_average ?? 0.0)"
    }
    
    func saveUserDefautls() {
//
//        if let encoded = try? JSONEncoder().encode(favorite) {
//            UserDefaults.standard.set(encoded, forKey: UserDKeys.favorites.rawValue)
//        }
        
//        if let data = UserDefaults.standard.object(forKey: UserDKeys.favorites.rawValue) as? [InfoMoviesProtocol],
//           let category = try? JSONDecoder().decode(favorite, from: data) {
//             print(category.name)
//        }
//        let array = favoriteMoviesArray.append(movie)
//
//        if let encoded = try? JSONEncoder().encode(array) {
//            UserDefaults.standard.set(encoded, forKey: UserDKeys.favorites.rawValue)
        
        }
        
        
        
        
    
    
    //MARK: - Buttons

}

//MARK: - Extensiones

//MARK: - recommendation movies services
extension DetailsViewModel {
    
    func getRecommendationMovies() {
        movieAPI.getMovies(category: .Recommendation, idMovie: movieDetail.value.id ?? 0) { [weak self] movieArray, _ in
            self?.recommendationMovies.value = movieArray
        }
    }
    
    func getRecommendationMoviesTitle(index: Int) -> String? {
        recommendationMovies.value[index].title
    }
    
    func getRecommendationMoviesCount() -> Int? {
        recommendationMovies.value.count
    }
    
    func getRecommendationPath(){
        
    }
    
    func getRecommendationPath(index: Int) -> String? {
        recommendationMovies.value[index].poster_path
    }
}

//MARK: - Similar movies services
extension DetailsViewModel {
    
    func getSimilarMovies() {
        movieAPI.getMovies(category: .similar, idMovie: movieDetail.value.id ?? 0) { [weak self] movieArray, _ in
            self?.similarMovies.value = movieArray
        }
    }
    
    func getSimilarMoviesTitle(index: Int) -> String? {
        similarMovies.value[index].title
    }
    
    func getSimilarMoviesCount() -> Int? {
        similarMovies.value.count
    }
    
    func getSimilarPath(index: Int) -> String? {
        similarMovies.value[index].poster_path
    }
}

//MARK: - Cast movie services
extension DetailsViewModel {
    
    func getCastMovie() {
        movieAPI.getCast(idMovie: movieDetail.value.id ?? 0) { [weak self] movieArray, _ in
            self?.castMovie.value = movieArray
        }
    }
    
    func getCastMovieTitle(index: Int) -> String? {
         castMovie.value[index].name
    }
    
    func getCastMovieMoviesCount() -> Int? {
        castMovie.value.count
    }
    
    func getCastMovieMoviesCharacter(index: Int) -> String? {
        castMovie.value[index].character
    }
    
    func getCastPath(index: Int) -> String? {
        castMovie.value[index].profile_path
    }
}


