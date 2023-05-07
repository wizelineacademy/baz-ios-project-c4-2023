//
//  MovieListLocal.swift
//  BAZProject
//
//  Created by jmgarciaca on 06/05/23.
//

import Foundation

enum ResultStorageOperation {
    case success
    case fail
}

protocol StorableProtocol {
    func storeData(completion: @escaping (ResultStorageOperation) -> ())
    func retriveData<T>(resource: Resource<T>) -> T?
}

class MovieListLocal {
    var movieList: MovieList = MovieList(results: [])
    
    init() {
        getMovies() { [weak self] moveList in
            self?.movieList = moveList
        }
    }
    
    func addMovie(_ movie: Movie, completion: @escaping (ResultStorageOperation) -> ()) {
        movieList.results.append(movie)
        storeData(completion: completion)
    }
    
    func getMovies(completion: @escaping (MovieList) -> ()) {
        
        let resource = Resource<MovieList>(url: nil) { data in
            return try? JSONDecoder().decode(MovieList.self, from: data)
        }

        guard let retrive = retriveData(resource: resource) else {
            return
        }
        
        completion(retrive)
    }
    
    func deleteMovie(_ movie_id: Int, completion: @escaping (ResultStorageOperation) -> ()) {

        if let index = movieList.results.firstIndex(where: { $0.id == movie_id }) {
            movieList.results.remove(at: index)
            storeData(completion: completion)
        }
    }
    
    func findMovie(_ movie_id: Int) -> Movie? {
        
        if let index = movieList.results.firstIndex(where: { $0.id == movie_id }) {
            return movieList.results[index]
        }
        
        return nil
    }
}

extension MovieListLocal {
    static var typeName: String {
        return String(describing: self)
    }
}

extension MovieListLocal: StorableProtocol {
    
    func storeData(completion: @escaping (ResultStorageOperation) -> ()) {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(movieList)
            UserDefaults.shared.set(data, forKey: "MovieList")
            completion(ResultStorageOperation.success)
        } catch {
            completion(ResultStorageOperation.fail)
        }
    }
    
    func retriveData<T>(resource: Resource<T>) -> T? {
        
        if let data = UserDefaults.shared.data(forKey: "MovieList") {
            return resource.parse(data)
        }
        
        return nil
    }
}
