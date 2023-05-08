//
//  MediaTableViewCellTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
@testable import BAZProject

final class MediaTableViewCellTests: XCTestCase {
    
    var sut: MediaTableViewCell!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = try MediaTableViewCell.fromNib()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_SetCell_ShouldSetItemsWithModel() {
        let model = MediaTableViewCellModel(title: "title", subtitle: "subtitle", image: nil, defaultImage: "poster", footNote: "footnote", rated: true)
        let expectedImage = UIImage(named: "poster")
        
        sut.setCell(with: model)
        
        XCTAssertEqual(sut.posterImageView.image, expectedImage)
        XCTAssertEqual(sut.titleLabel.text, model.title)
        XCTAssertEqual(sut.subtitleLabel.text, model.subtitle)
        XCTAssertEqual(sut.ratingLabel.text, model.footNote)
    }
    
    func test_SetCell_ImageShouldBeNilFromModel() {
        let model = MediaTableViewCellModel(title: "title", subtitle: "subtitle", image: nil, defaultImage: nil, footNote: "footnote", rated: true)
        
        sut.setCell(with: model)
        
        XCTAssertNil(sut.posterImageView.image)
    }
    
    func test_SetCell_ShouldHaveYellowStarDecoratorWhenMediaRated() {
        let model = MediaTableViewCellModel(title: nil, subtitle: nil, image: nil, defaultImage: nil, footNote: "footnote", rated: true)
        let expectedDecorator = UIImage(systemName: "star.fill")
        
        sut.setCell(with: model)
        
        XCTAssertEqual(sut.decorImageView.image, expectedDecorator)
        XCTAssertEqual(sut.decorImageView.tintColor, .systemYellow)
    }
    
    func test_SetCell_ShouldHaveGrayClockDecoratorWhenMediaNotRated() {
        let model = MediaTableViewCellModel(title: nil, subtitle: nil, image: nil, defaultImage: nil, footNote: "footnote", rated: false)
        let expectedDecorator = UIImage(systemName: "clock")
        
        sut.setCell(with: model)
        
        XCTAssertEqual(sut.decorImageView.image, expectedDecorator)
        XCTAssertEqual(sut.decorImageView.tintColor, .systemGray)
    }
    
    func test_SetCell_ShouldHideDecoratorAndRatingItemsWhenModelFootnoteIsNil() {
        let model = MediaTableViewCellModel(title: nil, subtitle: nil, image: nil, defaultImage: nil, footNote: nil, rated: false)
        
        sut.setCell(with: model)
        
        XCTAssert(sut.ratingLabel.isHidden)
        XCTAssert(sut.decorImageView.isHidden)
    }
    
    func test_SetCell_ShouldHideSubtitleContainerViewWhenModelSubtitleIsNil() {
        let model = MediaTableViewCellModel(title: nil, subtitle: nil, image: nil, defaultImage: nil, footNote: nil, rated: false)
        
        sut.setCell(with: model)
        
        XCTAssert(sut.subtitleLabel.superview?.isHidden ?? false)
    }
    
    func test_prepareForReuse_ShouldFlushImage() {
        let model = MediaTableViewCellModel(title: nil, subtitle: nil, image: nil, defaultImage: "poster", footNote: nil, rated: false)
        
        sut.setCell(with: model)
        sut.prepareForReuse()
        
        XCTAssertNil(sut.posterImageView.image)
    }

}
