//
//  DetailInfo.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import Foundation

public struct DetailInfo {
    public var movie: Movie
    private var arrRecomended: [Movie]?
    private var arrSimilar: [Movie]?
    
    init(movie: Movie, arrRecomended: [Movie]? = nil, arrSimilar: [Movie]? = nil) {
        self.movie = movie
        self.arrRecomended = arrRecomended
        self.arrSimilar = arrSimilar
    }
}
