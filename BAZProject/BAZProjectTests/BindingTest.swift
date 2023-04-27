//
//  BindingTest.swift
//  BAZProject
//
//  Created by Manuel S on 20/04/23.
//

import XCTest
@testable import BAZProject

final class BoxTests: XCTestCase {
    
    private var sutString: Box<String>!
    private var sutInt: Box<Int>!
    private var sut: Box<Bool>!
    
    override func setUp() {
        super.setUp()
        sutString = Box<String>(value: "")
        sutInt = Box<Int>(value: 0)
        sut = Box<Bool>(value: false)
    }
    
    override func tearDown() {
        sutString = Box<String>(value: "")
        sutInt = Box<Int>(value: 0)
        sut = Box<Bool>(value: false)
        super.tearDown()
    }
    
    func test_initializeWithAnyType_objectIsNil() {
        XCTAssertNotNil(sutString)
        XCTAssertNotNil(sutInt)
    }
    
    func test_initializeWithAnyType_objectIsNotNil() {
        sutString = Box<String>(value: String())
        sutInt = Box<Int>(value: 0)
        XCTAssertNotNil(sutString.value)
        XCTAssertNotNil(sutInt.value)
    }
    
    func test_valueChange_throughSetter() {
        sutString = Box<String>(value: "Hola")
        sutString.value = "Bye"
        XCTAssertEqual(sutString.value, "Bye")
    }
    
    func test_BoxDidBind_ShouldFulfillExpectationByBind() {
        let expectation = XCTestExpectation()
        expectation.assertForOverFulfill = true
        var box = Box(value: 2)
        
        box.bind {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
    }
    
    func test_BoxDidBind_ShouldFulfillExpectationByValueChange() {
        let expectation = XCTestExpectation()
        expectation.assertForOverFulfill = true
        expectation.expectedFulfillmentCount = 2
        var box = Box(value: 2)

        box.bind {
            expectation.fulfill()
        }
        box.value = 3
        wait(for: [expectation], timeout: 0.2)
    }
}
