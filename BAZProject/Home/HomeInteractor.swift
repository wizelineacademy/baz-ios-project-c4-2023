//  HomeInteractor.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

// MARK: - Class
class HomeInteractor {
    // MARK: - Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var movies: [ListMovieProtocol]? = []
}

// MARK: - Extensions

// MARK: - P R E S E N T E R · T O · I N T E R A C T O R
extension HomeInteractor: HomeInteractorInputProtocol {
    // MARK: - Functions
    /**
     Function that returns a `UIImage` for a specific movie
     - Parameters:
        - index: The index of the url image
        - completion: Returns a UIImage
     - Returns: The image from data.
     - Version: 1.0.0
    */
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if let path = URL(string: "\(MovieAPIConstans.baseUrlImage)\(movies?[index].posterPath ?? "")") ?? URL(string: "") {
            let imageLoader: ImageLoader = ImageLoader()
            imageLoader.loadImage(from: path) { image in
                completion(image)
            }
        }
    }
    
    /**
     Function that gets an array of movies
     - Version: 1.0.0
    */
    func getDataMovies(endPoint: Endpoint, completion: @escaping () -> Void) {
        let movieApi = MovieAPI()
        movieApi.fetchData(model: Movie.self, endPoint) { [weak self] result in
            switch result {
            case .failure(let fail):
                completion()
                print(fail.localizedDescription)
            case .success(let response):
                self?.movies = response.results
                guard let favorites = self?.getFavorites(), let origin = self?.movies else {
                    self?.presenter?.presentDataMovies(movies: self?.movies)
                    completion()
                    return
                }
                for i in 0..<origin.count {
                    for j in 0..<favorites.count {
                        if origin[i].id == favorites[j].id {
                            self?.movies![i].isFavorite = true
                        }
                    }
                }
                self?.presenter?.presentDataMovies(movies: self?.movies)
                completion()
            }
        }
    }
    
    func saveFavorite(index: Int, onSaved: @escaping () -> Void) {
        guard let favorite = self.movies?[index] as? MovieResult else { return }
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let List = try? JSONDecoder().decode([MovieResult].self, from: data) {
                debugPrint(List)
                var updatedList = [MovieResult]()
                List.forEach { show in
                    updatedList.append(show)
                }
                if !updatedList.contains(where: {$0.id == favorite.id }) {
                    updatedList.append(favorite)
                }
                debugPrint(updatedList)
                if let encoded = try? JSONEncoder().encode(updatedList) {
                    UserDefaults.standard.set(encoded, forKey: "SavedData")
                    
                    if let data = UserDefaults.standard.data(forKey: "SavedData") {
                        if let decoded = try? JSONDecoder().decode([MovieResult].self, from: data) {
                            debugPrint(decoded)
                            onSaved()
                            return
                        }
                    }
                }
            }
        } else {
            var updatedList = [MovieResult]()
            updatedList.append(favorite)
            debugPrint(updatedList)
            if let encoded = try? JSONEncoder().encode(updatedList) {
                UserDefaults.standard.set(encoded, forKey: "SavedData")
                
                if let data = UserDefaults.standard.data(forKey: "SavedData") {
                    if let decoded = try? JSONDecoder().decode([MovieResult].self, from: data) {
                        debugPrint(decoded)
                        onSaved()
                        return
                    }
                }
            }
        }
    }
    
    func deleteFavorite(index: Int, onSaved: @escaping () -> Void) {
        print("delete favorite")
        guard let favorite = self.movies?[index] as? MovieResult else { return }
        
        onSaved()
    }
    
    func getFavorites() -> [MovieResult]? {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode([MovieResult].self, from: data) {
                //debugPrint(decoded)
                return decoded
            }
        }
        return nil
    }
    
}
