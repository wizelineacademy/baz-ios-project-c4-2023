//
//  ServiceApiTests.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 27/03/23.
//

import XCTest
import BAZProject

final class ServiceApiTests: XCTestCase {

    var errorType: ErrorApi?
    var exp: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        exp = expectation(description: "This is the failure")
    }
    
    override func tearDown() {
        super.tearDown()
        exp = nil
        errorType = nil
    }
    
    func test_BadURL_ReturnURLError() {
        //Given
        let strHostVoid = ""
        let configuration = URLConfiguration(strHost: strHostVoid, path: .noPath)
        let sut: NetworkingProtocol = ServiceApi<MovieService>(configuration: configuration)
        //When
        sut.search { [weak self] (result: Result<MovieService, ErrorApi>) in
            switch result {
            case .success(_):
                break
            case .failure(let failure):
                self?.errorType = failure
            }
            self?.exp?.fulfill()
        }
        //Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(errorType, ErrorApi.badURL)
        
    }
    
    func test_MalformedURL_ReturnBadResponseError() {
        //Given
        let strBadHost = "Esto es un mal host"
        let configuration = URLConfiguration(strHost: strBadHost, path: .noPath)
        let sut: NetworkingProtocol = ServiceApi<MovieService>(configuration: configuration)
        //When
        sut.search { [weak self] (result: Result<MovieService, ErrorApi>) in
            switch result {
            case .success(_):
                break
            case .failure(let failure):
                self?.errorType = failure
            }
            self?.exp?.fulfill()
        }
        //Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(errorType, ErrorApi.badResponse)
    }
    
}
