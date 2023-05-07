//
//  TrendingMediaSectionsTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 07/05/23.
//

import XCTest
import BAZProject

final class TrendingMediaSectionsTests: XCTestCase {

    func test_titles_getSectionTitlesForTrending() {
        let expectedTitle = "Trending"
        
        let sectionTitle = TrendingMediaSection.trending.title
        
        XCTAssertEqual(expectedTitle, sectionTitle)
    }
    
    func test_titles_getSectionTitlesForNowPlaying() {
        let expectedTitle = "Now Playing"
        
        let sectionTitle = TrendingMediaSection.nowPlaying.title
        
        XCTAssertEqual(expectedTitle, sectionTitle)
    }
    
    func test_titles_getSectionTitlesForPopular() {
        let expectedTitle = "Popular"
        
        let sectionTitle = TrendingMediaSection.popular.title
        
        XCTAssertEqual(expectedTitle, sectionTitle)
    }
    
    func test_titles_getSectionTitlesForTopRated() {
        let expectedTitle = "Top Rated"
        
        let sectionTitle = TrendingMediaSection.topRated.title
        
        XCTAssertEqual(expectedTitle, sectionTitle)
    }
    
    func test_titles_getSectionTitlesForUpcoming() {
        let expectedTitle = "Coming Soon"
        
        let sectionTitle = TrendingMediaSection.upcoming.title
        
        XCTAssertEqual(expectedTitle, sectionTitle)
    }
    
}
