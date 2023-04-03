//
//  TrendingEntity.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//  
//

import Foundation

struct TrendingEntity {
    
    var strNavBarTitle: String = "Trending"
    private var arrMovies: [Movie]?
    
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
