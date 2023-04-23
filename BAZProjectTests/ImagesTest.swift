//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by ksolano on 30/03/23.
//

import XCTest
@testable import BAZProject

final class ImagesTests: XCTestCase {
    
    var loader: ImageLoader!
    
    override func setUp() {
        super.setUp()
        loader = ImageLoader()
    }
    
    override func tearDown() {
        super.tearDown()
        loader = nil
    }
    
    // test number of movies and not nil array for show
    func testMovies_isNotNil_getImage() {
        // Given
        guard let urlFetch = URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg") else {
            return
        }
        // When
        loader.loadImage(urlData: urlFetch) { image in
            // Then
            XCTAssertNotNil(image)
        }
    }
}
