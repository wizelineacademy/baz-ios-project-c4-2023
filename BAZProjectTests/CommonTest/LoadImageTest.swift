//
//  LoadImageTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 25/04/23.
//

import XCTest
@testable import BAZProject

final class LoadImageTest: XCTestCase {

    private var sut: ImageRemoteLoader!
    private var url: URL!
    private var corruptedURL: URL!
    
    override func setUp() {
        super.setUp()
        sut = ImageRemoteLoader()
        url = URL(string: ApiConstans.baseUrlImage + "/8c4a8kE7PizaGQQnditMmI1xbRp.jpg")
        corruptedURL = URL(string: ApiConstans.baseUrlImage + "nilimage.jpg")
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        url = nil
        corruptedURL = nil
    }
    
    func test_loadImage_returnImage(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        sut.loadFrom(url: url) { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_loadImage_returnNil(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        sut.loadFrom(url: corruptedURL) { image in
            XCTAssertNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
