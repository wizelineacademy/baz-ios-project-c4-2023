//
//  MocksMovies.swift
//  BAZProject
//
//  Created by ksolano on 31/03/23.
//

@testable import BAZProject
import Foundation

struct MockMoviesFecth {
    // Mock array of Movies for test use, some movies with all the information and some without all the information for testing cases.
    static let moviesFecth: [MovieProtocol] =  [Movie(id: 100, title: "Avengers", poster_path: "path/avengers"),
                                        Movie(id: 1726, title: "Iron Man", poster_path: "/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg"),
                                        Movie(id: 101, title: "Batman", poster_path: "path/batman"),
                                        Movie(id: 155, title: "El caballero oscuro", poster_path: "/8QDQExnfNFOtabLDKqfDQuHDsIg.jpg"),
                                        Movie(id: 102, title: "Spiderman", poster_path: "path/spidermanNoWayHome"),
                                        Movie(id: 604, title: "Matrix Reloaded", poster_path: "/ayZkaN2f3ASjWW8ooCfuJT3T8Va.jpg")]
}


