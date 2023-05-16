//
//  ApiTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 25/04/23.
//

import XCTest
@testable import BAZProject

///Clase que implementa las prubeas unitarias de MovieApi
final class ApiTest: XCTestCase {
    
    ///Movie fake
    private var fakeMovies: [ListMovieProtocol]!
    
    ///Sut
    private var sut: FakeMovieApi!
    
    ///Metodo Inicializador de variables para las pruebas unitarias
    override func setUp() {
        super.setUp()
        fakeMovies = []
        sut = FakeMovieApi(resultType: .sucess)
    }
    
    ///Metodo que desinicializa  de variables para las pruebas unitarias
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovies = nil
    }
    
    ///Test del enum de errores de MovieDB
    func test_ErrorApis(){
        let error = ApiError.defaultError
        XCTAssertEqual(error.localizedDescription, "Error por defecto")
    }
    
    ///Test del metodo fetch para la llamada a MovieDB
    func test_apicall_retrunSucess(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        guard let url = MovieCategories.topRated.urlRequest else { return }
        sut.fetch(request:url) {(result: Result<MovieResult?, Error>) in
            switch result {
            case .failure(let fail):
                print(fail)
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}

///clase que implementa los test para los endpoinst de Movie DB
final class ApiTestEndpoints: XCTestCase {
    
    ///Movie fake
    private var fakeMovies: [ListMovieProtocol]!
    
    //Sut
    private var sut: FakeMovieApi!
    
    ///Metodo que desinicializa  de variables para las pruebas unitarias
    override func setUp() {
        super.setUp()
        fakeMovies = []
        sut = FakeMovieApi(resultType: .fail(ApiError.defaultError))
    }
    
    ///Metodo que desinicializa  de variables para las pruebas unitarias
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovies = nil
    }
    
    ///Test de error en el api de Movie DB
    func test_apicall_retrunError(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        guard let url = MovieCategories.topRated.urlRequest else { return }
        sut.fetch(request: url) {(result: Result<MovieResult?, Error>) in
            switch result {
            case .failure(let fail):
                XCTAssertNotNil(fail)
                expectation.fulfill()
            case .success(let response):
                print(response?.results?.first?.title ?? "")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    ///Test que implementa el retorno del enpoint correctamente
    func test_MoviesCategoriesEnum_returnVariables(){
        let endpointNowPlaying = BAZProject.MovieCategories.nowPlaying
        let endpointTopRated = BAZProject.MovieCategories.topRated
        let endpointPopular = BAZProject.MovieCategories.popular
        let endpointTrending = BAZProject.MovieCategories.trending
        let endpointUpComing = BAZProject.MovieCategories.upComing
        
        XCTAssertEqual(endpointNowPlaying.endPoint, "movie/now_playing")
        XCTAssertEqual(endpointTopRated.endPoint, "movie/top_rated")
        XCTAssertEqual(endpointPopular.endPoint, "movie/popular")
        XCTAssertEqual(endpointTrending.endPoint, "trending/movie/day")
        XCTAssertEqual(endpointUpComing.endPoint, "movie/upcoming")
        
        let urlString = endpointNowPlaying.pathBase + endpointNowPlaying.endPoint + endpointNowPlaying.apiKey
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        XCTAssertEqual(endpointNowPlaying.urlRequest, request)
        
    }
    
    
    ///Test que implementa el retorno del enpoint de moviewDetail correctamente  
    func test_MovieDetailInfoEnum_returnVariables(){
        let fakeId = "123456789"
        let endpointSimilar = BAZProject.MovieDetailInfo.similar(fakeId)
        let endpointRecomended = BAZProject.MovieDetailInfo.recomended(fakeId)
        let endpointImage = BAZProject.MovieDetailInfo.image(fakeId)
        let endpointReviews = BAZProject.MovieDetailInfo.reviews(fakeId)
        let endpointCredits = BAZProject.MovieDetailInfo.credits(fakeId)
        let endpointSearch = BAZProject.MovieDetailInfo.search(fakeId)
        
        XCTAssertEqual(endpointSimilar.endPoint, "movie/\(fakeId)/similar")
        XCTAssertEqual(endpointRecomended.endPoint, "movie/\(fakeId)/recommendations")
        XCTAssertEqual(endpointImage.endPoint, fakeId)
        XCTAssertEqual(endpointReviews.endPoint, "movie/\(fakeId)/reviews")
        XCTAssertEqual(endpointCredits.endPoint, "movie/\(fakeId)/credits")
        XCTAssertEqual(endpointSearch.endPoint, "&query=\(fakeId)")
        
        
        let urlString = endpointSimilar.pathBase + endpointSimilar.endPoint + endpointSimilar.apiKey
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        XCTAssertEqual(endpointSimilar.urlRequest, request)
        
        let urlSearchString = endpointSearch.pathBase + "search/movie" + endpointSearch.apiKey + endpointSearch.endPoint
        guard let searchUrl = URL(string: urlSearchString) else { return }
        let searchRequest = URLRequest(url: searchUrl)
        
        XCTAssertEqual(endpointSearch.urlRequest, searchRequest)

    }
}
