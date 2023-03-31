//
//  TrendingMoviesViewModelMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 30/03/23.
//

import Foundation
@testable import BAZProject

class TrendingMoviesViewModelMock: TrendingMoviesViewModel {
    
    override func getMovies(completion: @escaping () -> Void ) {
        completion()
    }
    
}
