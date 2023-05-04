//
//  SearchFakes.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import Foundation
@testable import BAZProject

class SearchFakes: SearchRepository {
    
    func searchMovies(query: String, completion: @escaping ([Movie]) -> Void) {
        let movies = [
            Movie(id: 567, title: "Inception", posterPath: "/dferfrgervfdrt3535.png", overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.", voteAverage: 8.0, releaseDate: randomDate())
        ]
        completion(movies)
    }
    
    func searchKeyword(query: String, completion: @escaping ([String]) -> Void) {
        let keywords = ["dreams", "subconscious", "heist"]
        completion(keywords)
    }
}
