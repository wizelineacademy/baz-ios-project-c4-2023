//
//  ServiceApiTests.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 27/03/23.
//

import XCTest
@testable import BAZProject

final class ServiceApiTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_UrlWasConfigured_InServiceAPI(){
        //Given
        let strFinalURL : String = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        //When
        let service = ServiceApi()
        let strServiceURL = service.configureURL(forPath: "/trending/movie/day")
        //Then
        XCTAssertEqual(strFinalURL, strServiceURL)
    }

}
