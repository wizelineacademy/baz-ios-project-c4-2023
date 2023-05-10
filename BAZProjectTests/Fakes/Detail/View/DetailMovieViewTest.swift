//
//  DetailMovieViewTest.swift
//  BAZProjectTests
//
//  Created by bvelazquezva on 09/05/23.
//

import XCTest
@testable import BAZProject

final class DetailMovieViewTest: XCTestCase {
    var sut: DetailMovieView!
    var movieDetailPage: [ListSectionMovieDetail]? = []
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = DetailMovieView()
        movieDetailPage = DetailMovieEntity().movieDetailData.pageData
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        movieDetailPage = nil
        super.tearDown()
        
    }
    
    // MARK: - UICollectionView - Test
    func test_CollectionHasSetDatasource() {
        XCTAssertNotNil(sut?.clvRevSimRec.dataSource)
        
    }
    
    func test_CollectionHasSetDelegate() {
        XCTAssertNotNil(sut?.clvRevSimRec.delegate)
    }

    func test_CollectionConformToDelegate() {
        XCTAssert(((sut?.conforms(to: UICollectionViewDelegate.self)) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.collectionView(_:cellForItemAt:)))) != nil))
    }

    func test_Collection_WhenCellRowHasZeroElements(){
        let movieDetailData = MovieDetailData()
        sut.updateData(data: movieDetailData.pageData)
        XCTAssertEqual(sut.clvRevSimRec.dataSource?.collectionView(sut.clvRevSimRec, numberOfItemsInSection: 0), 0)
    }
    
    func test_getImage_whenIsNil(){
        sut.getImage("")
        XCTAssertNil(sut.imvBackPoster.image)
        XCTAssertEqual(sut.lycImage.constant, 0)
        
    }
    
    func test_updateData_whenExistData(){
        guard let data = movieDetailPage else {return}
        sut.updateData(data: data)
        
        XCTAssertNil(sut.imvBackPoster.image)
        XCTAssertEqual(sut.lycImage.constant, 0)
        
    }
    
    func test_RegisterCells_whenNotNil(){
        sut.registrerCell()
        let indexPath = IndexPath()
        XCTAssertNotNil(sut.clvRevSimRec.dequeueReusableCell(withReuseIdentifier: GeneralCollectionViewCell.identifier, for: indexPath))
        XCTAssertNotNil(sut.clvRevSimRec.dequeueReusableCell(withReuseIdentifier: ReviewsCollectionViewCell.identifier, for: indexPath))
    }
    
    func testViewTitleMovie_whenThereTitle(){
        let expectedTitle = "John Wick 4"
        sut.titleMovie(expectedTitle)
        XCTAssertEqual(expectedTitle, sut.lblTitleView.text)
    }

}
