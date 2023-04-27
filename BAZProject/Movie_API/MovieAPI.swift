//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    /**
     Get trending movies for day.
     
     The completion handler takes the following parameters:
     
     - Parameters:
        - arrMovies: Return an array of  type`MovieInfo` protocol.
     */
    func getTrendingMovies(completion: @escaping (_ movies: [MovieInfo]?) -> Void) {
        URLSessionManager.request(strURL: "/3/trending/movie/day?language=es&region=MX&page=1", body: String()) { (response: ServiceResponse<[Movie]>?, error: NSError?) in
            if let arrMovies = response?.result {
                completion(arrMovies)
            } else {
                completion(nil)
            }
        }
    }

    /**
     Get now playing movies..
     
     The completion handler takes the following parameters:
     
     - Parameters:
        - arrMovies: Return an array of  type`MovieInfo` protocol.
     */
    func getNowPlayingMovies(completion: @escaping (_ movies: [MovieInfo]?) -> Void) {
        URLSessionManager.request(strURL: "/3/movie/now_playing?&language=es&region=MX&page=1", body: String()) { (response: ServiceResponse<[Movie]>?, error: NSError?) in
            if let arrMovies = response?.result {
                completion(arrMovies)
            } else {
                completion(nil)
            }
        }
    }
    
    /**
     Get popular movies.
     
     The completion handler takes the following parameters:
     
     - Parameters:
        - arrMovies: Return an array of  type`MovieInfo` protocol.
     */
    func getPopularMovies(completion: @escaping (_ movies: [MovieInfo]?) -> Void) {
        URLSessionManager.request(strURL: "/3/movie/popular?&language=es&region=MX&page=2", body: String()) { (response: ServiceResponse<[Movie]>?, error: NSError?) in
            if let arrMovies = response?.result {
                completion(arrMovies)
            } else {
                completion(nil)
            }
        }
    }
    
    /**
     Get top rate movies.
     
     The completion handler takes the following parameters:
     
     - Parameters:
        - arrMovies: Return an array of  type`MovieInfo` protocol.
     */
    func getTopRatedMovies(completion: @escaping (_ movies: [MovieInfo]?) -> Void) {
        URLSessionManager.request(strURL: "/3/movie/top_rated?&language=es&page=1&region=MX", body: String()) { (response: ServiceResponse<[Movie]>?, error: NSError?) in
            if let arrMovies = response?.result {
                completion(arrMovies)
            } else {
                completion(nil)
            }
        }
    }
    
    /**
     Get upcoming movies.
     
     The completion handler takes the following parameters:
     
     - Parameters:
        - arrMovies: Return an array of  type`MovieInfo` protocol.
     */
    func getUpcomingMovies(completion: @escaping (_ movies: [MovieInfo]?) -> Void) {
        URLSessionManager.request(strURL: "/3/movie/upcoming?&language=es&region=MX&page=1", body: String()) { (response: ServiceResponse<[Movie]>?, error: NSError?) in
            if let arrMovies = response?.result {
                completion(arrMovies)
            } else {
                completion(nil)
            }
        }
    }
    
    /**
     Search movies with a key word.
     
     - Parameters:
        - keyword: A string that represents the keyword(s) for the search.
     */
    func searchMoviesfor(keyword: String, completion: @escaping (_ movies: [MovieFoundInfo]?) -> Void) {
        URLSessionManager.request(strURL: "/3/search/keyword?&language=es&query=\(keyword)", body: String()) { (response: ServiceResponse<[MovieFound]>?, error: NSError?) in
            if let arrMovies = response?.result {
                completion(arrMovies)
            } else {
                completion(nil)
            }
        }
    }
}
