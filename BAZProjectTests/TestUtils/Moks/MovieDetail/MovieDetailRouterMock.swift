//
//  MovieDetailRouter.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import Foundation
@testable import BAZProject

enum MovieDetailRouterCalls{
    case sendToReviews
   
}

///Clase mock de MovieDetailPresenter
final class MovieDetailRouterMock: MoviewDetailWireframeProtocol{
    
    var calls: [MoviesPresenterCalls] = []
    
    ///metodo que llama sendToReviews del router
    func sendToReviews(reviews: [BAZProject.Review]) {
        calls.append(.setMovies)
    }

}
