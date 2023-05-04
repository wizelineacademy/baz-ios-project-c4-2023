//
//  MovieViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import XCTest
@testable import BAZProject

final class MovieViewModelTests: XCTestCase {

    var sut: MovieViewModel!
    var fakeRepository: MovieRepository!

    override func setUp() {
        super.setUp()
        fakeRepository = MovieFakes()
        let movie = Movie(id: 603, title: "Matrix", posterPath: "/ererv5g534.jpg", overview: "Lorem ipsum", voteAverage: 5, releaseDate: "2019-12-10")
        sut = MovieViewModel(movie: movie, repository: fakeRepository)
    }
    
    override func tearDown() {
        sut = nil
        fakeRepository = nil
        super.tearDown()
    }
    
    func testFetchCharacters() {
        var actors: [Actor]?

        sut.onCharactersUpdate = { [self] in
            actors = sut.characters
        }
        XCTAssertNotNil(sut.onCharactersUpdate)
        sut.fetchCharacters()

        XCTAssertNotNil(actors)
        XCTAssertEqual(actors?.count, 4)
    }
    
    func testFetchReviews() {
        var reviews: [Review]?

        sut.onReviewsUpdate = { [self] in
            reviews = sut.reviews
        }
        XCTAssertNotNil(sut.onReviewsUpdate)
        sut.fetchReviews()

        XCTAssertNotNil(reviews)
        XCTAssertEqual(reviews?.count, 3)
    }
}
