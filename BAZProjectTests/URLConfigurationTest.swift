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


}
