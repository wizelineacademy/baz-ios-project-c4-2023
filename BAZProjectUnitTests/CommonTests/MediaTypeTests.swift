//
//  MediaTypeTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 27/04/23.
//

import XCTest
import BAZProject

final class MediaTypeTests: XCTestCase {

    
    func test_init_ShouldGetTVMediaType() {
        let expectedType = MediaType.tv
        let mediaType: MediaType?
        
        mediaType = MediaType(rawValue: "tv")
        
        XCTAssertEqual(expectedType, mediaType)
        XCTAssertEqual(expectedType.defaultImage, mediaType?.defaultImage)
        XCTAssertEqual(expectedType.itemTitle, mediaType?.itemTitle)
        XCTAssertEqual(expectedType.groupTitle, mediaType?.groupTitle)
    }
    
    func test_init_ShouldGetMoviesMediaType() {
        let expectedType = MediaType.movie
        let mediaType: MediaType?
        
        mediaType = MediaType(rawValue: "movie")
        
        XCTAssertEqual(expectedType, mediaType)
        XCTAssertEqual(expectedType.defaultImage, mediaType?.defaultImage)
        XCTAssertEqual(expectedType.itemTitle, mediaType?.itemTitle)
        XCTAssertEqual(expectedType.groupTitle, mediaType?.groupTitle)
    }
    
    func test_init_ShouldGetPersonMediaType() {
        let expectedType = MediaType.person
        let mediaType: MediaType?
        
        mediaType = MediaType(rawValue: "person")
        
        XCTAssertEqual(expectedType, mediaType)
        XCTAssertEqual(expectedType.defaultImage, mediaType?.defaultImage)
        XCTAssertEqual(expectedType.itemTitle, mediaType?.itemTitle)
        XCTAssertEqual(expectedType.groupTitle, mediaType?.groupTitle)
    }

    func test_init_ShouldGetNilMediaTypeViaRawValueNotFound() {
        let mediaType: MediaType?
        
        mediaType = MediaType(rawValue: "other")
        
        XCTAssertNil(mediaType)
    }

}
