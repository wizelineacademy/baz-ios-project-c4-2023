//
//  TrendingBarInteractorTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingBarInteractorTests: XCTestCase {
    
    private var sut: TrendingBarInteractorInputProtocol!
    private var remoteDataManager: TrendingBarRemoteDataManagerMock!

    override func setUpWithError() throws {
        sut = TrendingBarInteractor()
        remoteDataManager = TrendingBarRemoteDataManagerMock()
        sut.remoteData = remoteDataManager
    }

    override func tearDown() {
        sut = nil
        remoteDataManager = nil
        super.tearDown()
    }

    func testRequestMovieList() {
        let endPoint: Endpoint = .trending
        sut.fetchMovieList(endPoint)
        XCTAssert(remoteDataManager.calls.contains(.requestMovieList))
    }
    
    func testRequestImageData() {
        let movie = MovieResult(adult: false, backdropPath: "/ovM06PdF3M8wvKb06i4sjW3xoww.jpg", id: 76600, title: "Avatar: El sentido del agua", originalLanguage: "en", originalTitle: "Avatar: The Way of Water", overview: "Ambientada más de una década después de los acontecimientos de la primera película, 'Avatar: The Way of Water' empieza contando la historia de la familia Sully (Jake, Neytiri y sus hijos), los problemas que los persiguen, lo que tienen que hacer para mantenerse a salvo, las batallas que libran para seguir con vida y las tragedias que sufren.", posterPath: "/kUAG4ZQcsNbRyiPyAr3hLdsVgAq.jpg", mediaType: "movie", genreIds: [878,12,28], popularity: 3464.178, releaseDate: "2022-12-14", video: false, voteAverage: 7.7, voteCount: 5985)
        sut.fetchImageFrom(movie)
        XCTAssert(remoteDataManager.calls.contains(.requestImageData))
    }
}
