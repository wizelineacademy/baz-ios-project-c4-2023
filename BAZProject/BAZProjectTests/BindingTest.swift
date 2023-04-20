//
//  BindingTest.swift
//  BAZProject
//
//  Created by Manuel S on 20/04/23.
//

import XCTest
@testable import BAZProject


final class ObservableTests: XCTestCase {
    
    private var sutString: Box<String>!
    private var sutInt: Box<Int>!
    private var sut: Box<Bool>!
    private var listenerCalled: Bool!
    
    override func setUp() {
        super.setUp()
        sutString = Box<String>(value: "")
        sutInt = Box<Int>(value: 0)
        sut = Box<Bool>(value: false)
        listenerCalled = false
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
    
}
