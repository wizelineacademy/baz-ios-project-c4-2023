//
//  DetailLocalDataTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 07/05/23.
//

import XCTest
@testable import BAZProject

final class DetailLocalDataTests: XCTestCase {
    
    var sut: DetailLocalData!
    var udManager: UserDefaultsMock!
    
    override func setUp() {
        super.setUp()
        udManager = UserDefaultsMock()
        sut = DetailLocalData(userDefaultsManager: udManager)
    }
    
    override func tearDown() {
        sut = nil
        udManager = nil
        super.tearDown()
    }

    func test_SaveFavourite_ShouldSave() {
        let image = UIImage(named: "poster")!
        let data = image.pngData()!
        
        sut.save(data: data, key: "data")
        let retrieved = sut.findItem(for: "data")
        
        XCTAssert(retrieved)
    }
    
}
