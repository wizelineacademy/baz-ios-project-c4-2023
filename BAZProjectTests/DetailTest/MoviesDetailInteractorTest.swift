//
//  MoviesDetailInteractorTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 07/05/23.
//

import XCTest
@testable import BAZProject

final class MoviesDetailInteractorTest: XCTestCase{
    
    var presenter   : MockMoviesDetailPresenter?
    var sut         : MoviesDetailInteractor!
    let movieData   = MoviesViewModels(title: "The Super Mario Bros. Movie", original_title: "The Super Mario Bros. Movie", id: 502356, overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.")
    
    override func setUp() {
        super.setUp()
        sut = MoviesDetailInteractor(movieApi: MovieAPI(session: URLSession.shared), moviesInfo: movieData)
        presenter = MockMoviesDetailPresenter()
        sut.presenter = presenter
    }
    
    override func tearDown()  {
        super.tearDown()
        sut = nil
        presenter = nil
    }
    
    // Valid array ReviewsInformation is not nil
    func test_ZeroArray_ReviewsInformation(){
        //Given
        let expected = 2
        let info = getReviewsInformation()
        //When
        sut.presenter?.setResponseDetailsMovies(with: info)
        //Then
        XCTAssertEqual(presenter?.moviesMockReview.count, expected)
    }
    
    // Valid array ReviewsInformation is not nil
    func test_ZeroArray_InfoDetailData(){
        //Given
        let expected = 3
        let info = getInfoDetailData()
        //When
        sut.presenter?.setResponseDetail(with: info, detail: .Similars)
        //Then
        XCTAssertEqual(presenter?.moviesMockDetail.count, expected)
    }
    
    func getReviewsInformation() -> [ReviewsInformation] {
        let popularMovies: [ReviewsInformation] = [ReviewsInformation(author: "MSB",
                                                                      avatar_path: "/https://secure.gravatar.com/avatar/992eef352126a53d7e141bf9e8707576.jpg",
                                                                      content: "FULL SPOILER-FREE REVIEW @ https://www.firstshowing.net/2023/review-dungeons-dragons-honor-among-thieves-is-a-delightful-surprise/\r\n\r\n\"DUNGEONS & DRAGONS: HONOR AMONG THIEVES is one of the best fantasy films of the most recent years."),
                                                   ReviewsInformation(author: "Innovator",
                                                                      avatar_path: "/5U5amYZQ5TD9628GWvmjXtgZygT.jpg",
                                                                      content: "The numerous manuals on my shelves for 1st to 5e speak volumes of my familiarity with the game, as does the novels I own, and the numerous D&D computer games I\'ve played, so I was ecstatic seeing the places, people, and creatures I know very well.")]
        return popularMovies
    }
    
    func getInfoDetailData() -> [InfoDetailData] {
        let popularMovies: [InfoDetailModel] = [InfoDetailModel(title: "My Teacher Ate My Friend",
                                                                posterPath: "/5MiVG39r82aYUAtvs3bTycmbewJ.jpg",
                                                                overview: "Tomás, an 11-year-old boy living in his own fantasy world, must use his vast monster knowledge to fight against his new English teacher: a wicked woman who is, in fact, a child-eating monster."),
                                                   InfoDetailModel(title: "Demon Slayer: Kimetsu no Yaiba - Tsuzumi Mansion Arc",
                                                                   posterPath: "/7syc6DmjSeUSNp4VSGELfHQW17Q.jpg",
                                                                   overview: "Tanjiro ventures to the south-southeast where he encounters a cowardly young man named Zenitsu Agatsuma. He is a fellow survivor from Final Selection and his sparrow asks Tanjiro to help keep him in line."),
                                                   InfoDetailModel(title: "A",
                                                                   posterPath: "/y3DH68oWOGMZ637tqYHfTGU4Bif.jpg",
                                                                   overview: "A film director fades away from the industry after the failed love with the heroine of his movie. After being rehabilitated, he learns that some people conspired his fall and decides to take revenge.")]
        return popularMovies
    }
    
    // MARK: SetUpCorrect
    // Valid consultServiceSearch is not nil
    func testSearchServiceBlock(){
        XCTAssertNotNil(sut.getFavoriteMovies())
        XCTAssertNotNil(sut.addFavoriteMovies())
        XCTAssertNotNil(sut.removeFavoriteMovies())
        XCTAssertNotNil(sut.presenter?.setError())
    }
    
    func test_consultService(){
        sut.getSimilars()
    }
    
}
class MockMoviesDetailPresenter: MoviesDetailInteractorOutputProtocol {
    
    var moviesMockReview    : [ReviewsMovieData]    = [ReviewsMovieData]()
    var moviesMockDetail    : [InfoDetailData]      = [InfoDetailData]()
    
    func setResponseDetailsMovies(with resultReviews: [BAZProject.ReviewsMovieData]) {
        moviesMockReview = resultReviews
    }
    
    func setResponseDetail(with result: [BAZProject.InfoDetailData], detail typeDetail: BAZProject.OptionDetail?) {
        moviesMockDetail = result
    }
    
    func setError() {
        
    }
    
    func showBtnFavorites(with bIsOn: Bool?) {
        
    }
    
    
    
}
