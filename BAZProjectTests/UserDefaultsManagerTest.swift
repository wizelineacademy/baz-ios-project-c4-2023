//
//  UserDefaultsManagerTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 12/05/23.
//

import Foundation
import XCTest
import BAZProject

final class UserDefaultsManagerTest: XCTestCase {
    private var sut: UserDefaultsManager!
    private let movie = Movie(id: 1, title: "Test", poster_path: "Kohane.jpg", overview: "Algo que mostrar", release_date: "Una fecha")
    
    override func setUp() {
        super.setUp()
        sut = UserDefaultsManager()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testInfoIsDeleted() {
        //Given
        let arrSaved: [Movie]? = sut.getAll()
        sut.save(info: movie)
        //When
        sut.delete(info: movie)
        let arr: [Movie]? = sut.getAll()
        //Then
        XCTAssertEqual(arrSaved?.count, arr?.count)
    }
}
