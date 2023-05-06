//
//  DetailSectionTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 06/05/23.
//

import XCTest
import BAZProject

final class DetailSectionTests: XCTestCase {

    func test_getTitle_ForHeaderShouldBeNil() {
        let section = DetailSection.heading
        
        XCTAssertNil(section.title)
    }
    
    func test_getTitle_ForOverviewShouldBeNil() {
        let section = DetailSection.overview
        
        XCTAssertNil(section.title)
    }
    
    func test_getTitle_ForCastShouldBeEqual() {
        let section = DetailSection.cast
        
        XCTAssertEqual(section.title, "Top billed cast")
    }
    
    func test_getTitle_ForRecommendedShouldBeEqual() {
        let section = DetailSection.recommended
        
        XCTAssertEqual(section.title, "Recommendations")
    }
    
    func test_getTitle_ForSimilarShouldBeEqual() {
        let section = DetailSection.similar
        
        XCTAssertEqual(section.title, "More like this")
    }

    func test_getTitle_ForFilmographyShouldBeEqual() {
        let section = DetailSection.filmography
        
        XCTAssertEqual(section.title, "Filmography")
    }
    
}
