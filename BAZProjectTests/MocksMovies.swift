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
    static let moviesFecth: [Movie] =  [Movie(id: 100, title: "Avengers", poster_path: "path/avengers"),
                                        Movie(id: 1726, title: "Iron Man", poster_path: "/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg"),
                                        Movie(id: 101, title: "Batman", poster_path: "path/batman"),
                                        Movie(id: 155, title: "El caballero oscuro", poster_path: "/8QDQExnfNFOtabLDKqfDQuHDsIg.jpg"),
                                        Movie(id: 102, title: "Spiderman", poster_path: "path/spidermanNoWayHome"),
                                        Movie(id: 604, title: "Matrix Reloaded", poster_path: "/ayZkaN2f3ASjWW8ooCfuJT3T8Va.jpg")]
    // Mock for test movie review 
    static let moviesmockReview: MovieReview = MovieReview(author: "Antonio Alaminos-Fernández", author_details: AuthorDetails(name: "Antonio Alaminos-Fernández", username: "ALAMLEDP", avatar_path: "/oy8xcWyUEwI1zgIt9yMCCcFwlYo.png", rating: 9.0), content: "\"The Matrix,\" released in 1999, is widely considered to be one of the most influential and groundbreaking sci-fi films of the past 25 years. Directed by the Wachowskis, the film tells the story of Neo, a hacker who discovers that the reality he knows is actually a simulated world controlled by sentient machines. Keanu Reeves delivers a strong performance as Neo, and is supported by a talented cast including Carrie-Anne Moss, Laurence Fishburne, and Hugo Weaving. The film's unique blend of action, philosophy, and science fiction made it an instant classic, and its impact can still be felt in the genre today.", created_at: "2023-01-21T14:53:40.731Z", updated_at: "2023-01-21T14:53:40.815Z", url: "https://www.themoviedb.org/review/63cbfc74e24b93009b9c8d37")
}




