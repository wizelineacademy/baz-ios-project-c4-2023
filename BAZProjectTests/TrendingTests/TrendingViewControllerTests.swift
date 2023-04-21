//
//  TrendingViewControllerTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingViewControllerTests: XCTestCase {

    private var presenter: TrendingBarPresenterMock!
    private var sut: TrendingViewController!

    override func setUp() {
        super.setUp()
        presenter = TrendingBarPresenterMock()
        sut = makeSUT()
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func makeSUT() -> TrendingViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "TrendingViewController") as! TrendingViewController
        sut.presenter = presenter
        sut.loadViewIfNeeded()
        presenter.calls = []
        return sut
    }
    
    func test_didLoad_callsPresenterWillFetchMovieList() {
        sut.viewDidLoad()
        
        XCTAssertEqual(presenter.calls, [.willFetchMovieList])
    }
    
    func test_fillTrendingList_callsPresenterReloadInfo() {
        sut.fillTrendingList()
        
        XCTAssertEqual(presenter.calls, [.reloadInfo])
    }
    
    func test_goToSearchView_callsPresenterPresentSearchView() {
        sut.goToSearchView(sender: UIBarButtonItem())
        
        XCTAssertEqual(presenter.calls, [.presentSearchView])
    }
    
    func test_filterBy_callsPresenterPrepareActionSheet() {
        sut.filterBy(sender: UIBarButtonItem())
        
        XCTAssertEqual(presenter.calls, [.prepareActionSheet])
    }
    
    func test_Alert() {
        let VC = UIViewControllerSpy()
        var actions: [(String, UIAlertAction.Style)] = []
        actions.append(("Trending", UIAlertAction.Style.default))
        actions.append(("Now Playing", UIAlertAction.Style.default))
        actions.append(("Cancel", UIAlertAction.Style.cancel))
        
        Alerts.showActionsheet(viewController: VC, title: "", message: "", actions: actions) { index in }
        
        XCTAssertEqual(VC.calls, [.present])
    }
}
