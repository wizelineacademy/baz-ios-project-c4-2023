//
//  EndpointTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import XCTest
@testable import BAZProject

final class EndpointTests: XCTestCase {

    func test_getRequest_ShouldBeEqual() {
        let endpoint = GenericEndpoint(path: "/file")
        let expectedRequest = URLRequest(url: URL(string: "/file")!)
        
        let request = endpoint.getRequest()
        
        XCTAssertEqual(expectedRequest, request)
    }
    
    func test_getRequestQueriesWithOnlyKey_ShouldBeEqual() {
        let endpoint = GenericEndpoint(path: "/file", key: "aaa")
        let expectedRequest = URLRequest(url: URL(string: "/file?api_key=aaa")!)
        
        let request = endpoint.getRequest()
        
        XCTAssertEqual(expectedRequest, request)
    }
    
    func test_getRequestQueriesWithNotOnlyKey_ShouldBeEqual() {
        let endpoint = GenericEndpoint(path: "/file", queries: [URLQueryItem(name: "query", value: "lol")], key: "aaa")
        let expectedRequest = URLRequest(url: URL(string: "/file?query=lol&api_key=aaa")!)
        
        let request = endpoint.getRequest()
        
        XCTAssertEqual(expectedRequest, request)
    }
    
    func test_getRequestQueriesNilKey_ShouldBeEqual() {
        let endpoint = GenericEndpoint(path: "/file", queries: [URLQueryItem(name: "query", value: "lol")])
        let expectedRequest = URLRequest(url: URL(string: "/file?query=lol")!)
        
        let request = endpoint.getRequest()
        
        XCTAssertEqual(expectedRequest, request)
    }
}
