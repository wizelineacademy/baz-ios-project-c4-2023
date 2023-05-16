//
//  LoadImageTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 25/04/23.
//

import XCTest
@testable import BAZProject

///clase que implementa los test para la carga de imagenes en Movie DV
final class LoadImageTest: XCTestCase {
    
    ///Sut
    private var sut: ImageRemoteLoader!
    
    //Url Fake
    private var url: URL!
    
    ///Url de con error 
    private var corruptedURL: URL!
    
    ///Metodo que desinicializa  de variables para las pruebas unitarias
    override func setUp() {
        super.setUp()
        sut = ImageRemoteLoader()
        url = MovieDetailInfo.image("/8c4a8kE7PizaGQQnditMmI1xbRp.jpg").imageUrl
        corruptedURL = URL(string: "nilimage.jpg")
    }
    
    ///Metodo que desinicializa  de variables para las pruebas unitarias
    override func tearDown() {
        super.tearDown()
        sut = nil
        url = nil
        corruptedURL = nil
    }
    
    /// Tes de carga de imagen correctemente de la api de Movie DB
    func test_loadImage_returnImage(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        sut.loadFrom(url: url) { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /// Tes de carga de imagen erronea de la api de Movie DB
    func test_loadImage_returnNil(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        sut.loadFrom(url: corruptedURL) { image in
            XCTAssertNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
