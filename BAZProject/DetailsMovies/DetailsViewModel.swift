//
//  DetailsViewModel.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import Foundation

class DetailsViewModel: DetailsProtocol {
    
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
        do {
            guard let movie = movieDetail.value as? Movie else { return }
            if let data = UserDefaults.standard.data(forKey: UserDKeys.favorites.rawValue) {
                var UDData = try JSONDecoder().decode([Movie].self, from: data)
                UDData.append(movie)
                let data = try JSONEncoder().encode(UDData)
                UserDefaults.standard.set(data, forKey: UserDKeys.favorites.rawValue)
            } else {
                let data = try JSONEncoder().encode([movie])
                UserDefaults.standard.set(data, forKey: UserDKeys.favorites.rawValue)
            }
            
        } catch {
            print("Can not store:", error)
            
        }
        print("se agrego")

    }
    
    func deteleUserDefautls() {
        do {
            guard let movie = movieDetail.value as? Movie else { return }
            if let data = UserDefaults.standard.data(forKey: UserDKeys.favorites.rawValue) {
                var UDData = try JSONDecoder().decode([Movie].self, from: data)
                
                for (index, element) in UDData.enumerated() {
                    if element.id == movie.id {
                        UDData.remove(at: index)
                    }
                }
                let data = try JSONEncoder().encode(UDData)
                UserDefaults.standard.set(data, forKey: UserDKeys.favorites.rawValue)
            }
        } catch {
            print("Can not store:", error)
        }
        print("se elimino")
        
    }
    
    func isMovieFavorite() -> Bool {
        var fav = false
        do {
            guard let movie = movieDetail.value as? Movie else { return  false }
            guard let data = UserDefaults.standard.data(forKey: UserDKeys.favorites.rawValue) else { return false }
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


