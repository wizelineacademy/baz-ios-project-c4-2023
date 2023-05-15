//
//  TrendingEntity.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//  
//

import Foundation

public struct TrendingEntity {
    var strNavBarTitle: String = NSLocalizedString("Trending", comment: "Trending")
    private var arrMovies: [Movie]?
    
    public init(strNavBarTitle: String = NSLocalizedString("Trending", comment: "Trending"), arrMovies: [Movie]? = nil) {
        self.strNavBarTitle = strNavBarTitle
        self.arrMovies = arrMovies
    }
    
    mutating func updateMovies(with arrMovies: [Movie]?) {
        self.arrMovies = arrMovies
    }
    
    func getNumberOfRows() -> Int? {
        return arrMovies?.count
    }
    
    func getMovie(forRow iRow: Int) -> Movie? {
        return arrMovies?[iRow]
    }
}
