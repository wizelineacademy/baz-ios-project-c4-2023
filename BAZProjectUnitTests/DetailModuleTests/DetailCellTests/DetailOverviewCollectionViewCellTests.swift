//
//  DetailOverviewCollectionViewCellTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 06/05/23.
//

import XCTest
@testable import BAZProject

final class DetailOverviewCollectionViewCellTests: XCTestCase {

    var sut: DetailOverviewCollectionViewCell!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = try DetailOverviewCollectionViewCell.fromNib()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_SetCellWith_ModelDataShouldApplyToCell() {
        let model = DetailOverview(largeTitle: "Harry Potter", smallSubtitle: "The boy who livec", image: nil, description: "WOW", defaultImage: "poster")
        let expectedImage = UIImage(named: "poster")
        
        sut.setCell(with: model)
        
        XCTAssertEqual(sut.titleLabel.text, model.largeTitle)
        XCTAssertEqual(sut.subtitleLable.text, model.smallSubtitle)
        XCTAssertEqual(sut.descriptionLabel.text, model.description)
        XCTAssertEqual(sut.posterImage.image, expectedImage)
    }
}
