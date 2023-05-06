//
//  DetailEndpointTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
@testable import BAZProject

final class DetailEndpointTests: XCTestCase {

    func test_getRequest_MovieRequestShouldBeEqual() {
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/18?append_to_response=recommendations,reviews,similar,credits&api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")!)
        
        let endpoint = DetailEndpoint.movie(18)
        let actualRequest = endpoint.getRequest()
        
        XCTAssertEqual(request, actualRequest)
    }

    func test_getRequest_TVRequestShouldBeEqual() {
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/tv/18?append_to_response=recommendations,reviews,similar,credits&api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")!)
        
        let endpoint = DetailEndpoint.tv(18)
        let actualRequest = endpoint.getRequest()
        
        XCTAssertEqual(request, actualRequest)
    }
    
    func test_getRequest_PersonRequestShouldBeEqual() {
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/person/18?append_to_response=combined_credits&api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")!)
        
        let endpoint = DetailEndpoint.person(18)
        let actualRequest = endpoint.getRequest()
        
        XCTAssertEqual(request, actualRequest)
    }

}

