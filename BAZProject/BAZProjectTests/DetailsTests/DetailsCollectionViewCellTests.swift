//
//  DetailsCollectionViewCellTests.swift
//  BAZProject
//
//  Created by Manuel S on 06/05/23.
//

import XCTest
@testable import BAZProject

final class DetailsCollectionViewCellTests: XCTestCase {
    
    var sut: DetailsCollectionViewCell?
    var viewModel: DetailsViewModel?

    override func setUp() {
        super.setUp()
        
        sut = try! DetailsCollectionViewCell.initFromNib()
        viewModel =  DetailsViewModel(movieDetail: Movie(id: 1, title: "Harry Potter", poster_path: "HP.jpg", overview: "Always", vote_average: 10.0))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDetailsViewCell_CollectionView_SimilarTitleCell_NotNil() {
        //Then
        sut?.setInfo(viewModel!, indexPath: IndexPath(row: 0, section: 0), type: .similar)
        //When
        XCTAssertNotNil(sut?.txtLabel.text)
    }
    
    
    func testDetailsViewCell_CollectionView_RecommendationTitleCell_NotNil() {
        //Then
        sut?.setInfo(viewModel!, indexPath: IndexPath(row: 0, section: 0), type: .recommendation)
        //When
        XCTAssertNotNil(sut?.txtLabel.text)
    }
    
    func testDetailsViewCell_CollectionViewTitleCell_Empty() {
        //Then
        sut?.awakeFromNib()
        //Then
        XCTAssertEqual(sut?.txtLabel.text, "")
    }
}
