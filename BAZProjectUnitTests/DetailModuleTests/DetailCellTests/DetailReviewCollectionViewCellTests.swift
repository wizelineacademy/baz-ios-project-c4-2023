//
//  DetailReviewCollectionViewCellTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 06/05/23.
//

import XCTest
@testable import BAZProject

final class DetailReviewCollectionViewCellTests: XCTestCase {

    var sut: DetailReviewCollectionViewCell!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = try DetailReviewCollectionViewCell.fromNib()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_SetCellWith_ModelDataShouldApplyToCell() {
        let date = DateFormatter.getString(from: Date())
        let model = DetailReview(author: "Leon S. Kennedy", content: "LoveZombies", date: date)
        
        sut.setCell(with: model)
        
        XCTAssertEqual(sut.authorLabel.text, model.author)
        XCTAssertEqual(sut.contentLabel.text, model.content)
        XCTAssertEqual(sut.dateLabel.text, model.date)
    }

}
