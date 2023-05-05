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
    func getReleaseDate() -> String
}

protocol ViewToPresenterProtocol {
    var interactor: PresenterToInteractor? { get set }
    var trendingMovies: [Viewable] { get set }
    var nowPlayingMovies: [Viewable] { get set }
    var popularMovies: [Viewable] { get set }
    var topRatedMovies: [Viewable] { get set }
    var upcomingMovies: [Viewable] { get set }
    
    func getMoviesData()
    
    func getNumberOfItems(_ items: [Viewable]) -> Int
    
    func getCellText(_ items: [Viewable],index: IndexPath) -> String
    
    func getCellImage(_ items: [Viewable], index: IndexPath) -> UIImage
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
