//
//  TrendingPresenter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//  
//

import Foundation
import UIKit

public class TrendingPresenter {
    // MARK: Properties
    weak public var view: TrendingViewProtocol?
    public var interactor: TrendingInteractorInputProtocol?
    public var router: TrendingRouterProtocol?
    
    public init(view: TrendingViewProtocol? = nil, interactor: TrendingInteractorInputProtocol? = nil, router: TrendingRouterProtocol? = nil) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension TrendingPresenter: TrendingPresenterProtocol {
    public func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
        view?.createNavigationButton()
        view?.registerXIB()
        interactor?.getMovies(withFilter: .trending)
    }
    
    public func getNumberOfRows() -> Int? {
        return interactor?.getNumberOfRows()
    }
    
    public func getMovie(forRow iRow: Int) -> Movie? {
        return interactor?.getMovie(forRow: iRow)
    }
    
    public func goToDetail(forIndex iRow: Int) {
        if let movie = getMovie(forRow: iRow) {
            router?.goToDetail(for: movie, from: view)
        }
    }
    
    public func barButtonWasPressed() {
        let alert = createOptionAlert()
        router?.present(alert, from: view)
    }
    
    private func createOptionAlert() -> UIAlertController {
        let alert = UIAlertController(title: NSLocalizedString("Filter options", comment: "Filter options"), message: NSLocalizedString("Choose among these options", comment: "Choose among these options"), preferredStyle: .actionSheet)
        let trendingAction = UIAlertAction(title: NSLocalizedString("Trending", comment: "Trending"), style: .default) { [weak self] _ in
            self?.view?.setNavigationTitle(for: NSLocalizedString("Trending", comment: "Trending"))
            self?.interactor?.getMovies(withFilter: .trending)
        }
        alert.addAction(trendingAction)
        let nowPlayingAction = UIAlertAction(title: NSLocalizedString("Now Playing", comment: "Now Playing"), style: .default) { [weak self] _ in
            self?.view?.setNavigationTitle(for: NSLocalizedString("Now Playing", comment: "Now Playing"))
            self?.interactor?.getMovies(withFilter: .nowPlaying)
        }
        alert.addAction(nowPlayingAction)
        let popularAction = UIAlertAction(title: NSLocalizedString("Popular", comment: "Popular"), style: .default) { [weak self] _ in
            self?.interactor?.getMovies(withFilter: .popular)
            
        }
        alert.addAction(popularAction)
        let topRatedAction = UIAlertAction(title: NSLocalizedString("Top Rated", comment: "Top Rated"), style: .default) { [weak self] _ in
            self?.view?.setNavigationTitle(for: NSLocalizedString("Top Rated", comment: "Top Rated"))
            self?.interactor?.getMovies(withFilter: .topRated)
        }
        alert.addAction(topRatedAction)
        let upcomingAction = UIAlertAction(title: NSLocalizedString("Upcoming", comment: "Upcoming"), style: .default) { [weak self] _ in
            self?.view?.setNavigationTitle(for: NSLocalizedString("Upcoming", comment: "Upcoming"))
            self?.interactor?.getMovies(withFilter: .upcoming)
        }
        alert.addAction(upcomingAction)
        let favoriteAction = UIAlertAction(title: NSLocalizedString("Favorites", comment: "Favorites"), style: .default) { [weak self] _ in
            self?.view?.setNavigationTitle(for: NSLocalizedString("Favorites", comment: "Favorites"))
            self?.interactor?.getMovies(withFilter: nil)
        }
        alert.addAction(favoriteAction)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel)
        alert.addAction(cancelAction)
        return alert
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    public func serviceRespondedSuccess() {
        view?.reloadTable()
    }
    
    public func serviceFailed(withError error: ErrorApi) {
        router?.showAlert(withMessage: error.getMessage(), from: view)
    }
}
