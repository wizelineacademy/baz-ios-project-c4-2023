//
//  TrendingMoviesProtocols.swift
//  BAZProject
//
//  Created Octavio Labastida Luna on 19/04/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import UIKit

//MARK: Wireframe -
protocol TrendingMoviesWireframeProtocol: AnyObject {
    func getResultViewController() -> UIViewController
}
//MARK: Presenter -
protocol TrendingMoviesPresenterProtocol: AnyObject {
    func getMovies()
    func setMovies(result: [ListMovieProtocol])
    func getResultViewController() -> UIViewController
    func getRemotImage(from stringURL: String, completion: @escaping (UIImage?) -> ())
    func findMovies(for string: String, completion: @escaping ([ListMovieProtocol]) -> ())
}

//MARK: Interactor -
protocol TrendingMoviesInteractorProtocol: AnyObject {
    var presenter: TrendingMoviesPresenterProtocol?  { get set }
    func getMovies()
    func getRemotImage(from stringURL: String, completion: @escaping (UIImage?) -> ())
    func findMovies(for string: String, completion: @escaping ([ListMovieProtocol]) -> ())
}

//MARK: View -
protocol TrendingMoviesViewProtocol: AnyObject {
    var presenter: TrendingMoviesPresenterProtocol?  { get set }
    var restoredState: RestorableState {get set}
    func loadData(movies: [ListMovieProtocol])
}
