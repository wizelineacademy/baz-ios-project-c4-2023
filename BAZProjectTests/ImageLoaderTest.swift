//
//  ImageLoaderTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 20/04/23.
//

import XCTest
@testable import BAZProject

/// The `ImageLoaderTest` class is responsible for testing the functionality of the `ImageLoader` class, which is used to load images from a given URL.
final class ImageLoaderTest: XCTestCase {
    
    // MARK: - Properties

    /// The subject under test.
    private var sut: ImageLoader!
    
    // MARK: - Set up and tear down
    
    override func setUp() {
        super.setUp()

        // Set up the initial state of the subject under test.
        self.sut = ImageLoader()
    }
    
    override func tearDown() {
        // Clean up the state of the subject under test.
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test methods
    
    /// This test method checks the functionality of the `ImageLoader` class by loading an image from a given URL and comparing it with an expected image.
    ///
    /// Steps:
    /// 1. Create an `imageExpected` variable and assign it to `nil`.
    /// 2. If the URL for the expected image is valid, retrieve the data from the URL and create a UIImage from the data.
    /// 3. Set up a `viewModel` object and a fake `moveList` object using a `MovieListViewModel` instance.
    /// 4. Set the movies in the `viewModel` to the movies in the fake `moveList` object.
    /// 5. Retrieve the first movie from the `viewModel`.
    /// 6. If the `poster_path` property of the movie is valid, retrieve the image from the URL and compare it with the `imageExpected`.
    /// 7. Create an `expectation` object to track the completion of the image retrieval.
    /// 8. Call the `getImage` method of the `sut` object to retrieve the image from the URL and compare it with the `imageExpected`.
    /// 9. Fulfill the `expectation` object when the image retrieval is complete.
    /// 10. Wait for the `expectation` object to be fulfilled within a specified timeout period.
    func testImageLoader_checkImageLoader() {
        
        var imageExpected: UIImage!
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg"), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            imageExpected = image
        }
        
        let viewModel = MovieListViewModel(.trending)
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().trending)
        viewModel.setMovies(moveListFake?.results ?? [])
        
        let movie = viewModel.movieAtIndex(0)
        
        if let poster_path = movie?.poster_path, let url = URL(string: poster_path) {
            
            let expectation = XCTestExpectation(description: "Obteniendo datos de la imagen")
            
            sut.getImage(from: url) { image in
                if let strImageTest = image.base64, let strImageExpected = imageExpected.base64 {
                    XCTAssertEqual(strImageTest, strImageExpected)
                }
                
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 5)
        }
    }
}
