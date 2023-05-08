//
//  MovieListLocal.swift
//  BAZProject
//
//  Created by jmgarciaca on 06/05/23.
//

import Foundation

/// Enum that represents the result of a storage operation.
enum ResultStorageOperation {
    case success
    case fail
}

/// Protocol for objects that can store and retrieve data.
protocol StorableProtocol {
    
    /// Stores data using the given completion handler to return the result of the operation.
    /// - Parameter completion: The completion handler that will be called with the result of the operation.
    func storeData(completion: @escaping (ResultStorageOperation) -> ())
    
    /// Retrieves data using the given resource and returns the result.
    /// - Parameter resource: The resource used to retrieve the data.
    /// - Returns: The retrieved data if it exists, nil otherwise.
    func retriveData<T>(resource: Resource<T>) -> T?
}

/// Class that manages the local storage of a list of movies.
final class MovieListLocal {
    
    /// The list of movies stored locally.
    var movieList: MovieList = MovieList(results: [])
    
    /// Initializes a new instance of the `MovieListLocal` class and retrieves the list of movies from local storage.
    init() {
        getMovies() { [weak self] moveList in
            self?.movieList = moveList
        }
    }
}

extension MovieListLocal {
    
    /// Computed property for the name of the MovieListLocal class.
    static var typeName: String {
        return String(describing: self)
    }
}

extension MovieListLocal {
    
    /// Adds a new movie to the list and stores the updated list in local storage using the given completion handler to return the result of the operation.
    /// - Parameter movie: The movie to add to the list.
    /// - Parameter completion: The completion handler that will be called with the result of the operation.
    func addMovie(_ movie: Movie, completion: @escaping (ResultStorageOperation) -> ()) {
        movieList.results.append(movie)
        storeData(completion: completion)
    }
    
    /// Retrieves the list of movies from local storage using the given completion handler to return the result of the operation.
    /// - Parameter completion: The completion handler that will be called with the retrieved list of movies.
    func getMovies(completion: @escaping (MovieList) -> ()) {
        
        let resource = Resource<MovieList>(url: nil) { data in
            return try? JSONDecoder().decode(MovieList.self, from: data)
        }

        guard let retrive = retriveData(resource: resource) else {
            return
        }
        
        completion(retrive)
    }
    
    /// Deletes a movie from the list with the given ID and stores the updated list in local storage using the given completion handler to return the result of the operation.
    /// - Parameter movie_id: The ID of the movie to delete.
    /// - Parameter completion: The completion handler that will be called with the result of the operation.
    func deleteMovie(_ movie_id: Int, completion: @escaping (ResultStorageOperation) -> ()) {

        if let index = movieList.results.firstIndex(where: { $0.id == movie_id }) {
            movieList.results.remove(at: index)
            storeData(completion: completion)
        }
    }
    
    /// Finds a movie with the given ID in the list and returns it if it exists.
    /// - Parameter movie_id: The ID of the movie to find.
    /// - Returns: The movie with the given ID if it exists, nil otherwise.
    func findMovie(_ movie_id: Int) -> Movie? {
        
        if let index = movieList.results.firstIndex(where: { $0.id == movie_id }) {
            return movieList.results[index]
        }
        
        return nil
    }
}

/// StorableProtocol protocol extension for MovieListLocal to store and retrieve data using UserDefaults.
extension MovieListLocal: StorableProtocol {
    
    /// Stores the `movieList` data as JSON encoded data in `UserDefaults` with the key `MovieListLocal.typeName`.
    /// - Parameter completion: A closure to be executed once the storage operation is completed.
    ///                        The closure takes a `ResultStorageOperation` value that represents the result of the operation.
    ///                        The value will be `.success` if the data is stored successfully, otherwise it will be `.fail`.
    func storeData(completion: @escaping (ResultStorageOperation) -> ()) {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(movieList)
            UserDefaults.shared.set(data, forKey: MovieListLocal.typeName)
            completion(ResultStorageOperation.success)
        } catch {
            completion(ResultStorageOperation.fail)
        }
    }
    
    /// Retrieves the data stored in `UserDefaults` with the key `MovieListLocal.typeName`, and returns the parsed data.
    /// - Parameter resource: The `Resource` object to parse the data.
    /// - Returns: The parsed data as an instance of `T`. Returns `nil` if the data is not found or cannot be parsed.
    func retriveData<T>(resource: Resource<T>) -> T? {
        
        if let data = UserDefaults.shared.data(forKey: MovieListLocal.typeName) {
            return resource.parse(data)
        }
        
        return nil
    }
}
