//
//  DetailInfo.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import Foundation

public struct DetailInfo {
    public var movie: Movie
    private var arrRecomended: [Movie]?
    public var arrSimilar: [Movie]?
    public var arrReviews: [Review]?
    
    init(movie: Movie, arrRecomended: [Movie]? = nil, arrSimilar: [Movie]? = nil) {
        self.movie = movie
        self.arrRecomended = arrRecomended
        self.arrSimilar = arrSimilar
    }
    
    mutating func updateSimilarArray(with response: [MovieDetailService]?) {
        arrSimilar = nil
        arrSimilar = [Movie]()
        if let response = response, !response.isEmpty {
            for movieResponse in response {
                if let movieApp = movieResponse.convertToMovieApp() {
                    arrSimilar?.append(movieApp)
                }
                
            }
        }
    }
    
    mutating func updateReviewArray(with arrResponse: [ReviewService]?) {
        arrReviews = nil
        arrReviews = [Review]()
        if let arrResponse = arrResponse, !arrResponse.isEmpty {
            for reviewResponse in arrResponse {
                arrReviews?.append(reviewResponse.converteToReviewApp())
            }
        }
    }
}
