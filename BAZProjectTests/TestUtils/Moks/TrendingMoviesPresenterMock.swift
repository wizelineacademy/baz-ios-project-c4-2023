//
//  TrendingMoviesPresenterMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
import UIKit
@testable import BAZProject

enum TrendingMoviesPresenterCalls{
    case getMovies
    case getRemotImage
    case getResultViewController
    case findMovies
}

final class TrendingMoviesPresenterMock: TrendingMoviesPresenterProtocol{

    var calls: [TrendingMoviesPresenterCalls] = []
    
    func getMovies() {
        calls.append(.getMovies)
    }
    
    func setMovies(result: [BAZProject.ListMovieProtocol]) {
        calls.append(.getRemotImage)
    }
    
    func getResultViewController() -> UIViewController {
        calls.append(.getResultViewController)
        return UIViewController() as! TrendingMoviesViewController
    }
    
    func getRemotImage(from stringURL: String, completion: @escaping (UIImage?) -> ()) {
        calls.append(.getRemotImage)
    }
    
    func findMovies(for string: String, completion: @escaping ([BAZProject.ListMovieProtocol]) -> ()) {
        calls.append(.findMovies)
    }

}
