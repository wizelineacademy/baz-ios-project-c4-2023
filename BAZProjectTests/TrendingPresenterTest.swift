//
//  TrendingPresenterTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 28/04/23.
//

import Foundation
import XCTest
import BAZProject

final class TrendingPresenterTest: XCTestCase {
    enum NavigationCase {
        case alert
        case goToDetail
        case presentView
    }
    private var sut: TrendingPresenter?
    private var navigationCase: NavigationCase?
    
    override func setUp() {
        super.setUp()
        sut = TrendingPresenter(interactor: nil)
        sut?.router = self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        navigationCase = nil
    }
    
    func testAlertIsPresented() {
        //Given
        let navCase: NavigationCase = .presentView
        //When
        sut?.barButtonWasPressed()
        //Then
        XCTAssertEqual(navCase, navigationCase)
    }
    
    func testOnErrorAlertIsPresented() {
        //Given
        let navCase: NavigationCase = .alert
        //When
        sut?.serviceFailed(withError: .badJSON)
        //Then
        XCTAssertEqual(navCase, navigationCase)
    }
}

extension TrendingPresenterTest: TrendingRouterProtocol {
    static func createTrendingModule(withEntity entity: BAZProject.TrendingEntity) -> UIViewController {
        return UIViewController()
    }
    
    func showAlert(withMessage strMessage: String, from view: BAZProject.TrendingViewProtocol?) {
        navigationCase = .alert
    }
    
    func goToDetail(for movie: BAZProject.Movie, from view: BAZProject.TrendingViewProtocol?) {
        navigationCase = .goToDetail
    }
    
    func present(_ viewToPresent: UIViewController, from view: BAZProject.TrendingViewProtocol?) {
        navigationCase = .presentView
    }
    
    
}
