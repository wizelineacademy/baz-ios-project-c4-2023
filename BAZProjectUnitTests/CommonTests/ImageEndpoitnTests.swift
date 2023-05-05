//
//  ImageEndpoitnTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
@testable import BAZProject

final class ImageEndpoitnTests: XCTestCase {

    func test_init_ShouldBuildRequestCorrectly() {
        var components = URLComponents()
        components.host = "image.tmdb.org"
        components.path = "/t/p/w500/xyz.jpg"
        components.scheme = "https"
        let expectedRequest = URLRequest(url: components.url!, cachePolicy: .returnCacheDataElseLoad)
        let endpoint = ImageEndpoint(path: "/xyz.jpg")
        
        let request = endpoint.getRequest()
        
        XCTAssertEqual(expectedRequest, request)
    }

}
