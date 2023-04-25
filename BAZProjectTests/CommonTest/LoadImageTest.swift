//
//  LoadImageTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 25/04/23.
//

import XCTest
@testable import BAZProject

final class LoadImageTest: XCTestCase {

    private var sut: UIImage!
    private var url: URL!
    
    override func setUp() {
        super.setUp()
        sut = UIImage()
        url = URL(string: ApiConstans.baseUrlImage + "/8c4a8kE7PizaGQQnditMmI1xbRp.jpg")
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        
    }
    
    func test_loadImage(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        sut.loadFrom(url: url) { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
