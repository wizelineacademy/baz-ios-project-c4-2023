//
//  SearchLocalData.swift
//  BAZProject
//
//  Created by gescarcega on 30/04/23.
//

import Foundation

class SearchLocalData {
    
    func getRecentlySearchedMedia() -> [MediaItem]? {
        let date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        //TODO: Entregable 3 obtener de base de datos
        return [MediaItem(posterPath: "/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg", title: "Harry Potter and the Philosopher's Stone", rating: 7.9, mediaType: .movie), MediaItem(posterPath: "/eU1i6eHXlzMOlEq0ku1Rzq7Y4wA.jpg", title: "The Mandalorian", rating: 12.9, mediaType: .tv, releaseDate: date), MediaItem(posterPath: "/iPg0J9UzAlPj1fLEJNllpW9IhGe.jpg", title: "Daniel Radcliffe", mediaType: .person)]
    }
    
}
