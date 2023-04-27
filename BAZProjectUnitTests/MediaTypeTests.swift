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
        
        mediaType = MediaType("tv")
        
        XCTAssertEqual(expectedType, mediaType)
        XCTAssertEqual(expectedType.defaultImage, mediaType?.defaultImage)
        XCTAssertEqual(expectedType.itemTitle, mediaType?.itemTitle)
        XCTAssertEqual(expectedType.groupTitle, mediaType?.groupTitle)
    }
    
    func test_init_ShouldGetMoviesMediaType() {
        let expectedType = MediaType.movie
        let mediaType: MediaType?
        
        mediaType = MediaType("movie")
        
        XCTAssertEqual(expectedType, mediaType)
        XCTAssertEqual(expectedType.defaultImage, mediaType?.defaultImage)
        XCTAssertEqual(expectedType.itemTitle, mediaType?.itemTitle)
        XCTAssertEqual(expectedType.groupTitle, mediaType?.groupTitle)
    }
    
    func test_init_ShouldGetPersonMediaType() {
        let expectedType = MediaType.person
        let mediaType: MediaType?
        
        mediaType = MediaType("person")
        
        XCTAssertEqual(expectedType, mediaType)
        XCTAssertEqual(expectedType.defaultImage, mediaType?.defaultImage)
        XCTAssertEqual(expectedType.itemTitle, mediaType?.itemTitle)
        XCTAssertEqual(expectedType.groupTitle, mediaType?.groupTitle)
    }
    
    func test_init_ShouldGetNilMediaTypeViaNilArgument() {
        let mediaType: MediaType?
        
        mediaType = MediaType(nil)
        
        XCTAssertNil(mediaType)
        
    }
    
    func test_init_ShouldGetNilMediaTypeViaRawValueNotFound() {
        let mediaType: MediaType?
        
        mediaType = MediaType("other")
        
        XCTAssertNil(mediaType)
    }

}
