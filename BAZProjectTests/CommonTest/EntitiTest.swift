//
//  EntitiTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 08/05/23.
//

import XCTest

@testable import BAZProject

final class EntitiTest: XCTestCase {

    private var sutCast: Cast!
    private var sutMoview: Movie!

    
    override func setUp() {
        super.setUp()
        sutCast = Cast(adult: true, gender: 0, id: 0, knownForDepartment: "fakeText", name: "fakeText", originalName: "fakeText", popularity: 0.0, profilePath: "/fakeImagePath.jpg",creditID: "fakeText")
        sutMoview = Movie(id: 1, title: "ejemplo", posterPath: "/fakeImagePath.jpg", adult: false, backdropPath: "/fakeImagePath.jpg", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10, isFavorite: false)
    }
    
    override func tearDown() {
        super.tearDown()
        sutCast = nil
    }
    
    func test_UrlImageReturnURL(){
        let pathCast = sutCast.urlProfilePath
        XCTAssertEqual(pathCast, MovieDetailInfo.image("/fakeImagePath.jpg").imageUrl)
        
        let pathMoviePoster = sutMoview.urlImage
        let pathMovieProfile = sutMoview.urlBackdropImage
        
        XCTAssertEqual(pathMoviePoster, MovieDetailInfo.image("/fakeImagePath.jpg").imageUrl)
        XCTAssertEqual(pathMovieProfile, MovieDetailInfo.image("/fakeImagePath.jpg").imageUrl)
    }

}
