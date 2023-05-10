//
//  DetailMovieRouter.swift
//  BAZProjectTests
//
//  Created by bvelazquezva on 09/05/23.
//

import XCTest
@testable import BAZProject

final class DetailMovieRouterTest: XCTestCase {

    var movie: Movie?
    var entity: DetailMovieEntity?
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        movie = Movie(id: 603692, title: "John Wick 4", poster_path: "/gh2bmprLtUQ8oXCSluzfqaicyrm.jpg", backdrop_path: "/i8dshLvq4LE3s0v8PrkDdUyb1ae.jpg", overview: "John Wick descubre un camino para derrotar a la Alta Mesa. Pero para poder ganar su libertad, Wick deberá enfrentarse a un nuevo rival con poderosas alianzas en todo el mundo, capaz de convertir a viejos amigos en enemigos.", popularity: 2776.325, vote_average: 8.162, vote_count: 551)
        entity?.baseInfo = movie
    }

    override func tearDown() {
        movie = nil
        entity = nil
        super.tearDown()
        
    }
    
    // MARK: Test - View
    // Validate View is not nil
    
    func test_createModule_NotNil() {
        //Give
        guard let entity = entity else {return}
        //When
        let module = DetailMovieRouter.createDetailMovieModule(withEntity: entity)
        // then
        XCTAssertNotNil(module)
    }
    

}
