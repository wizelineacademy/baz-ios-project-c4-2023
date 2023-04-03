//
//  ServiceApiTests.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 27/03/23.
//

import XCTest
import BAZProject

final class ServiceApiTests: XCTestCase {

    var errorType : ErrorApi?
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
        let strBadHost = "Esto es un mal host"
        let configuration = URLConfiguration(strHost: strBadHost, path: .noPath)
        let sut: NetworkingProtocol = ServiceApi(serviceDelegate: self, configuration: configuration)
        //When
        sut.search()
        //Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(errorType, ErrorApi.badResponse)
    }
    
}

extension ServiceApiTests: ServiceApiProtocol{
    
    func serviceFinished(withResult result: Result<[String : Any], BAZProject.ErrorApi>) {
        switch result{
        case .failure(let error):
            exp?.fulfill()
            errorType = error
        default:
            return
        }
    }
}
