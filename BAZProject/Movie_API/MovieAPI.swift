//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import os

class MovieAPI {

    private let logger: Logger = Logger()
    
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
        URLSessionManager.request(strURL: "/3/search/keyword?language=es&query=\(keyword)", body: String()) { (response: ServiceResponse<[MovieFound]>?, error: NSError?) in
            if let arrMovies = response?.result {
                completion(arrMovies)
            } else {
                completion(nil)
            }
        }
    }
    
    func searchMovieDetails(for movieID: Int, completion: @escaping (_ movie: MovieDetailsInfo?) -> Void) {
        URLSessionManager.request(strURL: "/3/movie/\(movieID)?language=es", body: String()) { (response: MovieDetails?, error: NSError?) in
            if let movie = response {
                completion(movie)
            } else {
                completion(nil)
            }
        }
    }
    
    func searchMovieCredits(for movieID: Int, completion: @escaping (_ credits: MovieCreditsInfo?) -> Void) {
        URLSessionManager.request(strURL: "/3/movie/\(movieID)/credits?language=es", body: String()) { (response: MovieCredits?, error: NSError?) in
            if let credits = response {
                completion(credits)
            } else {
                completion(nil)
            }
        }
    }
    
    func searchMovieReviews(for movieID: Int, completion: @escaping (_ reviews: [MovieReviewInfo]?, _ error: NSError?) -> Void) {
        URLSessionManager.request(strURL: "/3/movie/\(movieID)/reviews?language=es", body: String()) { (response: ServiceResponse<[MovieReview]>?, error: NSError?) in
            if let reviews = response?.result {
                completion(reviews, nil)
            } else {
                self.logger.trace("\(error?.localizedDescription ?? "")")
                completion(nil, error)
            }
        }
    }
    
    func getSimilarMovies(to movieID: Int, completion: @escaping (_ movies: [MovieInfo]?, _ error: NSError?) -> Void) {
        URLSessionManager.request(strURL: "/3/movie/\(movieID)/similar?language=es", body: String()) { (response: ServiceResponse<[Movie]>?, error: NSError?) in
            if let movies = response?.result {
                completion(movies, nil)
            } else {
                self.logger.trace("\(error?.localizedDescription ?? "")")
                completion(nil, error)
            }
        }
    }
    
    func getRecommendationsMovies(to movieID: Int, completion: @escaping (_ movies: [MovieInfo]?, _ error: NSError?) -> Void) {
        URLSessionManager.request(strURL: "/3/movie/\(movieID)/recommendations?language=es", body: String()) { (response: ServiceResponse<[Movie]>?, error: NSError?) in
            if let movies = response?.result {
                completion(movies, nil)
            } else {
                self.logger.trace("\(error?.localizedDescription ?? "")")
                completion(nil, error)
            }
        }
    }
}
