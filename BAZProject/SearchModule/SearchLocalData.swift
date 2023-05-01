//
//  SearchLocalData.swift
//  BAZProject
//
//  Created by gescarcega on 30/04/23.
//

import Foundation

class SearchLocalData {
    
    func getRecentlyViewedMovies() -> [MediaItem] {
        //TODO: Entregable 3 obtener de base de datos
        return [MediaItem(posterPath: "/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg", title: "Harry Potter and the Philosopher's Stone", mediaType: .movie), MediaItem(posterPath: "/eU1i6eHXlzMOlEq0ku1Rzq7Y4wA.jpg", title: "The Mandalorian", mediaType: .tv), MediaItem(posterPath: "/iPg0J9UzAlPj1fLEJNllpW9IhGe.jpg", title: "Daniel Radcliffe", mediaType: .person)]
    }
    
}
