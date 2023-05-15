//
//  MovieDetailViewControllerTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 29/04/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailViewControllerTests: XCTestCase {
    private var presenter: MovieDetailPresenterMock!
    private var sut: MovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        presenter = MovieDetailPresenterMock()
        sut = makeSUT()
    }
    
    override func tearDown() {
        presenter = nil
        sut = nil
        super.tearDown()
    }
    
    func makeSUT() -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        sut.presenter = presenter
        presenter.movieModel.append(MockData().summary)
        sut.loadViewIfNeeded()
        return sut
    }
    
    func test_didLoad_callsPresenterWillFetchMovieList() {
        sut.viewDidLoad()
        
        XCTAssertEqual(presenter.calls.first, .getMovieBanner)
    }
    
    func test_SummaryCollectionCell() {
        let cell = sut.movieCollection.dequeueReusableCell(withReuseIdentifier: SummaryCollectionCell.reusableIdentifier, for: IndexPath(row: 0, section: 0)) as? SummaryCollectionCell
        let imgData = UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")?.pngData() ?? Data()
        
        
        cell?.setup(movieDetailModel: Movie(id: 1, title: "Prueba", posterPath: imgData, summary: "Prueba", backdropPath: "", backdropPathData: nil))
        
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell?.summaryLabel)
    }
    
    func test_MovieCollectionCell() {
        let cell = sut.movieCollection.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.reusableIdentifier, for: IndexPath(row: 0, section: 0)) as? MovieCollectionCell
        let imgData = UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")?.pngData() ?? Data()
        
        
        cell?.setup(movieDetailModel: Movie(id: 1, title: "Prueba", posterPath: imgData, summary: "Prueba", backdropPath: "", backdropPathData: nil))
        
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell?.movieTitle)
    }
    
    func test_StarringCollectionCell() {
        let cell = sut.movieCollection.dequeueReusableCell(withReuseIdentifier: StarringCollectionCell.reusableIdentifier, for: IndexPath(row: 0, section: 0)) as? StarringCollectionCell
        let imgData = UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")?.pngData() ?? Data()
        
        
        cell?.setup(movieDetailModel: ActorModel(name: "Max", profileImage: imgData))
        
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell?.nameLabel)
    }
    
    func test_ReviewCollectionCell() {
        let cell = sut.movieCollection.dequeueReusableCell(withReuseIdentifier: ReviewCollectionCell.reusableIdentifier, for: IndexPath(row: 0, section: 0)) as? ReviewCollectionCell
        let imgData = UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")?.pngData() ?? Data()
        
        
        cell?.setup(review: ReviewModel(name: "Max", rating: 2, content: "prueba", avatar: imgData))
        
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell?.raitingLabel)
    }
}
