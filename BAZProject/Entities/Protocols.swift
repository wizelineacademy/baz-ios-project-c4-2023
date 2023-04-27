//
//  Protocols.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 10/04/23.
//

import Foundation
import UIKit

protocol Viewable {
    func getTitle() -> String
    func getImagePath() -> String
    func getReleaseData() -> String
}

protocol ViewToPresenterProtocol {
    var interactor: PresenterToInteractor? { get set }
    
    func getMoviesData()
    
    func getNumberOfTrendingItems() -> Int
    func getNumberOfNowPlayingItems() -> Int
    func getNumberOfPopularItems() -> Int
    func getNumberOfTopRatedItems() -> Int
    func getNumberOfUpcomingItems() -> Int
    
    func getTrendingCellText(index: IndexPath) -> String
    func getNowPlayingCellText(index: IndexPath) -> String
    func getPopularCellText(index: IndexPath) -> String
    func getTopRatedCellText(index: IndexPath) -> String
    func getUpcomingCellText(index: IndexPath) -> String
    
    func getTrendingCellImage(index: IndexPath) -> UIImage
    func getNowPlayingCellImage(index: IndexPath) -> UIImage
    func getPopularCellImage(index: IndexPath) -> UIImage
    func getTopRatedCellImage(index: IndexPath) -> UIImage
    func getUpcomingCellImage(index: IndexPath) -> UIImage
}

protocol PresenterToViewProtocol {
    func reloadView()
}

protocol PresenterToInteractor {
    func getMoviesData()
}

protocol InteractorToPresenter {
    var trendingMovies: [Viewable] { get set }
    var nowPlayingMovies: [Viewable] { get set }
    var popularMovies: [Viewable] { get set }
    var topRatedMovies: [Viewable] { get set }
    var upcomingMovies: [Viewable] { get set }
}
