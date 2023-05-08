//
//  TrendingEndpointTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 07/05/23.
//

import XCTest
@testable import BAZProject

final class TrendingEndpointTests: XCTestCase {

    func test_pathShouldBeEqualForTrending() {
        let endpoint = TrendingEndpoint(section: .trending)
        
        let path = endpoint.path
        
        XCTAssertEqual(path, "/3/trending/all/week")
    }
    
    func test_pathShouldBeEqualForUpcoming() {
        let endpoint = TrendingEndpoint(section: .upcoming)
        
        let path = endpoint.path
        
        XCTAssertEqual(path, "/3/movie/upcoming")
    }
    
    func test_pathShouldBeEqualForNowPlaying() {
        let endpoint = TrendingEndpoint(section: .nowPlaying)
        
        let path = endpoint.path
        
        XCTAssertEqual(path, "/3/movie/now_playing")
    }
    
    func test_pathShouldBeEqualForTopRated() {
        let endpoint = TrendingEndpoint(section: .topRated)
        
        let path = endpoint.path
        
        XCTAssertEqual(path, "/3/movie/top_rated")
    }
    
    func test_pathShouldBeEqualForPopular() {
        let endpoint = TrendingEndpoint(section: .popular)
        
        let path = endpoint.path
        
        XCTAssertEqual(path, "/3/movie/popular")
    }
    
}
