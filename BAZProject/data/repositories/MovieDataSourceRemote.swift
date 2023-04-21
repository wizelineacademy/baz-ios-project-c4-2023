//
//  MovieDataSourceRemote.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

class MovieDataSourceRemote: MovieRepository {

    private let movieApi = MovieAPI()

    func getCast(movieID: Int, completion: @escaping ([Actor]) -> Void) {
        DispatchQueue.global().async {
            self.movieApi.getCastForMovie(movieID: movieID) { characters in
                completion(characters)
            }
        }
    }

    func getReviews(movieID: Int, completion: @escaping ([Review]) -> Void) {
        DispatchQueue.global().async {
            self.movieApi.getReviewsForMovie(movieID: movieID) { reviews in
                completion(reviews)
            }
        }
    }
}
