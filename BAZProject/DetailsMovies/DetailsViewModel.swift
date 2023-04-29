//
//  DetailsViewModel.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import Foundation

class DetailsViewModel: DetailsProtocol {
    
    var movieDetail: Box<ListMoviesProtocol>
    var recommendationMovies: Box<[ListMoviesProtocol]>
    var similarMovies: Box<[ListMoviesProtocol]>
    var castMovie: Box<[CastProtocol]>
    private var movieAPI: MovieAPI
    
    init(movieDetail: ListMoviesProtocol, remote: MovieAPI = MovieAPI() ) {
        self.movieDetail = Box(value: movieDetail)
        self.recommendationMovies = Box(value: [movieDetail])
        self.similarMovies = Box(value: [movieDetail])
        self.castMovie = Box(value: [Cast()])
        self.movieAPI = remote
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
        
    }
    
    func getCastMovieTitle(index: Int) -> String? {
        ""
    }
    
    func getCastMovieMoviesCount() -> Int? {
        0
    }
    
    func getCastMovieMoviesCharacter(index: Int) -> String? {
        ""
    }
    
    func getCastPath(index: Int) -> String? {
        similarMovies.value[index].poster_path
    }
}


