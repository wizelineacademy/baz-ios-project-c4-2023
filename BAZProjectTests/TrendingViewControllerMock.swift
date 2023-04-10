//
//  TrendingViewControllerMock.swift
//  BAZProjectTests
//
//  Created by Manuel S on 30/03/23.
//

import Foundation
@testable import BAZProject

final class TrendingViewModelMock: TrendingViewModel {
    
   override func getmovies(_ Completion: @escaping () -> Void) {
        Completion()
    }
}
