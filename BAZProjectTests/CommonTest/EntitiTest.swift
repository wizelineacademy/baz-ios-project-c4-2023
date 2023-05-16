//
//  EntitiTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 08/05/23.
//

import XCTest

@testable import BAZProject

///clase que implementa los test para las entiidades  de Movie DB
final class EntitiTest: XCTestCase {
    
    ///Sut de la entidad Cast
    private var sutCast: Cast!
    
    ///Sut de la entidad Movie
    private var sutMoview: Movie!

    ///Inicializador de las variables para las unit Test
    override func setUp() {
        super.setUp()
        sutCast = Cast(adult: true, gender: 0, id: 0, knownForDepartment: "fakeText", name: "fakeText", originalName: "fakeText", popularity: 0.0, profilePath: "/fakeImagePath.jpg",creditID: "fakeText")
        sutMoview = Movie(id: 1, title: "ejemplo", posterPath: "/fakeImagePath.jpg", adult: false, backdropPath: "/fakeImagePath.jpg", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)
    }
    
    ///Se  alimina la instancia de las variables para el test
    override func tearDown() {
        super.tearDown()
        sutCast = nil
        sutMoview = nil
    }
    
    ///Test que evalua si se forma correctamtente la URL de la propiedad de imagen 
    func test_UrlImageReturnURL(){
        let pathCast = sutCast.urlProfilePath
        XCTAssertEqual(pathCast, MovieDetailInfo.image("/fakeImagePath.jpg").imageUrl)
        
        let pathMoviePoster = sutMoview.urlImage
        let pathMovieProfile = sutMoview.urlBackdropImage
        
        XCTAssertEqual(pathMoviePoster, MovieDetailInfo.image("/fakeImagePath.jpg").imageUrl)
        XCTAssertEqual(pathMovieProfile, MovieDetailInfo.image("/fakeImagePath.jpg").imageUrl)
    }

}
