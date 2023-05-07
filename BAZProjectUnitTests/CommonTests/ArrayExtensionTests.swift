//
//  ArrayExtensionTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 07/05/23.
//

import XCTest
import BAZProject

final class ArrayExtensionTests: XCTestCase {

    func test_trimSizeLargerThanMax_ShouldReturnMaxElements() {
        let array = Array(0...20)
        let expectedArray = Array(0...9)
        
        let trimmedArray = array.trim(max: 10)
        
        XCTAssertEqual(expectedArray, trimmedArray)
    }
    
    func test_trimSizeSmallerThatMax_ShouldReturnSameElements() {
        let array = Array(0...5)
        
        let trimmedArray = array.trim(max: 10)
        
        XCTAssertEqual(array, trimmedArray)
    }

}
