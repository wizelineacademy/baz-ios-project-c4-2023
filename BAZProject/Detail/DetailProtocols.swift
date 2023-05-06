//
//  DetailProtocols.swift
//  BAZProject
//
//  Created by jehernandezg on 03/05/23.
//

import UIKit

// MARK: - V I E W (Presenter To View)
protocol DetailViewInputProtocol: AnyObject {
    // MARK: - Properties
    var presenter: DetailViewOutputProtocol? { get }
    // MARK: - Functions
    func showDetailMovie(detailMovie: ListMovieProtocol)
}

// MARK: - P R E S E N T E R (View To Presenter)
protocol DetailViewOutputProtocol {
    // MARK: - Properties
    var view: DetailViewInputProtocol? { get }
    var interactor: DetailInteractorInputProtocol { get }
    var router: DetailRouterProtocol { get }
    var detailMovie: ListMovieProtocol { get }
    // MARK: - Functions
    func getDetailMovie()
    func getOriginalMovieImage(imagePath: String, completion: @escaping (UIImage?) -> Void)
}

// MARK: - P R E S E N T E R (Interactor To Presenter)
protocol DetailInteractorOutputProtocol: AnyObject {
    // MARK: - Functions
    func presentDetailMovie(detailMovie: ListMovieProtocol)
}

// MARK: - I N T E R A C T O R (Presenter To Interactor)
protocol DetailInteractorInputProtocol {
    // MARK: - Properties
    var presenter: DetailInteractorOutputProtocol? { get }
    // MARK: - Functions
    func getDetailMovie(detailMoviePI: ListMovieProtocol)
    func getOriginalMovieImage(imagePath: String, completion: @escaping (UIImage?) -> Void)
}

// MARK: - R O U T E R (Presenter To Router)
protocol DetailRouterProtocol {
    var view: UIViewController? { get }
//    func showAnimation(completion: @escaping () -> Void)
//    func hideAnimation(completion: @escaping () -> Void)
}
