//
//  MediaCollectionViewCellTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

final class MediaCollectionViewCellTests: XCTestCase {
    
    var sut: MediaCollectionViewCell!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = try MediaCollectionViewCell.fromNib()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_SetCellWithModel_ShouldSetElements() {
        let model = MediaCollectionViewCellModel(title: "title", subtitle: "subtitle", image: nil, rated: true, defaultImage: "poster")
        let expectedImage = UIImage(named: "poster")
        
        sut.setCell(with: model)
        
        XCTAssertEqual(sut.titleLabel.text, model.title)
        XCTAssertEqual(sut.subtitleLabel.text, model.subtitle)
        XCTAssertEqual(sut.imageView.image, expectedImage)
    }
    
    func test_SetCellWithModel_ShouldSetDecorImageStar() {
        let model = MediaCollectionViewCellModel(title: "title", subtitle: "subtitle", image: nil, rated: true, defaultImage: "poster")
        let expectedImage = UIImage(systemName: "star.fill")
        
        sut.setCell(with: model)
        
        XCTAssertEqual(sut.decorImageView.image, expectedImage)
    }
    
    func test_SetCellWithModel_ShouldSetDecorClock() {
        let model = MediaCollectionViewCellModel(title: "title", subtitle: "subtitle", image: nil, rated: false, defaultImage: "poster")
        let expectedImage = UIImage(systemName: "clock")
        
        sut.setCell(with: model)
        
        XCTAssertEqual(sut.decorImageView.image, expectedImage)
    }
    
    func test_SetCellWithModel_ShouldHideSubtitleSection() {
        let model = MediaCollectionViewCellModel(title: "title", subtitle: nil, image: nil, rated: false, defaultImage: "poster")
        
        sut.setCell(with: model)
        
        XCTAssert(sut.subtitleLabel.isHidden)
        XCTAssert(sut.decorImageView.isHidden)
    }
    
    func test_prepareForReuse_ShouldFlushImage() {
        let model = MediaCollectionViewCellModel(title: "title", subtitle: nil, image: nil, rated: false, defaultImage: "poster")
        
        sut.setCell(with: model)
        sut.prepareForReuse()
        
        XCTAssertNil(sut.imageView.image)
    }
    
    func test_SetCellWithModel_ShouldBeNilImage() {
        let model = MediaCollectionViewCellModel(title: "title", subtitle: nil, image: nil, rated: false, defaultImage: nil)
        
        sut.setCell(with: model)
        
        XCTAssertNil(sut.imageView.image)
    }
    
}
