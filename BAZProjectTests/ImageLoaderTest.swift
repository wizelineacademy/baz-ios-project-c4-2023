//
//  ImageLoaderTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 20/04/23.
//

import XCTest
@testable import BAZProject

final class ImageLoaderTest: XCTestCase {

    private var sut: ImageLoader!
    
    override func setUp() {
        super.setUp()

        self.sut = ImageLoader()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testImageLoader_whenReadFromMock_checkNumberOfTreandingMovies() {
        
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

