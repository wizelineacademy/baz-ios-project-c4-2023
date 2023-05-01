//
//  KeyChainTests.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//
import XCTest
@testable import BAZProject

final class KeyChainTest: XCTestCase {
    
    private var sut: KeychainHelper?
    
    override func setUp() {
        super.setUp()
        sut = KeychainHelper.standard
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTredingViewModel_NotNil() {
        
        //Given
        
        //Then
        //When
//        sut?.save(<#T##data: Data##Data#>, service: <#T##String#>, account: <#T##String#>)
        
    }

    
    
}
