//
//  DispatchQueueMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 03/05/23.
//

import BAZProject
import XCTest

struct DispatchMock: DispatchProtocol {
    
    var expectation: XCTestExpectation?
    
    func async(executable: @escaping () -> Void) {
        DispatchQueue.main.async {
            executable()
            self.expectation?.fulfill()
        }
    }
    
    func asyncAfter(deadline: DispatchTime, executable: @escaping () -> Void) {
        DispatchQueue.main.async {
            executable()
            self.expectation?.fulfill()
        }
    }
    
}
