//
//  UserReviewTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 07/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

final class UserReviewTest: XCTestCase {
    
    var sut: UserReview!
    
    override func setUp() {
        super.setUp()
        sut = UserReview.instanceFromNib(Review(id: "238", author: "JuanesZ64", author_details: AuthorDetails(name: "", username: "JuanesZ64", avatar_path: "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg", rating: 9), content: "El comienzo de una Gran Trilogía de mafiosos, y una de las mejores películas del cine", created_at: "2023-02-25T06:31:06.197Z", updated_at: "2023-03-03T19:43:54.899Z")) as! UserReview

    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testUserReviewTest_ImageIsAsignedFromLoader() {
        XCTAssertNotNil(sut.imgView.image)
        
        let expectation = expectation(description: "image loader expectation")
        let result = XCTWaiter.wait(for: [expectation], timeout: 3.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(sut.imgView.image)
        } else {
            XCTFail("Failed on time out")
        }
    }
    
    
}


