//
//  URLConfigurationTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 03/04/23.
//

import XCTest
import BAZProject

final class URLConfigurationTest: XCTestCase {
    
    func test_UrlWasConfigured_InServiceAPI() {
        //Given
        let strFinalURL: String = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es"
        let urlFinal = URL(string: strFinalURL)
        let sut = URLConfiguration(path: .trending)
        //When
        let urlServiceURL = sut.configureURL()
        //Then
        XCTAssertEqual(urlFinal, urlServiceURL)
    }

    func test_URLForImage() {
        //Given
        let strDownloadURL = "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"
        let urlFinal = URL(string: strDownloadURL)
        let sut = URLConfiguration(strHost: "image.tmdb.org", path: .image(strFile: "/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"))
        //When
        let urlFromConfiguration = sut.configureURL()
        //Then
        XCTAssertEqual(urlFinal, urlFromConfiguration)
    }
    
    func testSearchUrl() {
        //Given
        let strUrl = "https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&query=Matrix"
        let finalUrl = URL(string: strUrl)
        let sut = URLConfiguration(path: .search(strQuery: "Matrix"))
        //When
        let urlFromConfiguration = sut.configureURL()
        //Then
        XCTAssertEqual(finalUrl, urlFromConfiguration)
    }
    
    func testQueryWithSpaces() {
        //Given
        let strUrl = "https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&query=Matrix%20revolutions"
        let finalUrl = URL(string: strUrl)
        let sut = URLConfiguration(path: .search(strQuery: "Matrix revolutions"))
        //When
        let urlFromConfiguration = sut.configureURL()
        //Then
        XCTAssertEqual(finalUrl, urlFromConfiguration)
    }
    
    func testForUpdatingPath() {
        //Given
        let strFinalURL: String = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es"
        let urlFinal = URL(string: strFinalURL)
        var sut = URLConfiguration(path: .noPath)
        //When
        sut.updatePath(with: .trending)
        let urlServiceURL = sut.configureURL()
        //Then
        XCTAssertEqual(urlFinal, urlServiceURL)
    }
    
    func testUpdateSearch() {
        //Given
        let strUrl = "https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&query=Matrix"
        let urlFinal = URL(string: strUrl)
        var sut = URLConfiguration(path: .noPath)
        //When
        sut.updatePath(with: .search(strQuery: "Matrix"))
        let urlServiceURL = sut.configureURL()
        //Then
        XCTAssertEqual(urlFinal, urlServiceURL)
    }

}
