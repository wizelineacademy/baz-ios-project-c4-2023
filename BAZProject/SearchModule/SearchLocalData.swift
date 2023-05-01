//
//  SearchLocalData.swift
//  BAZProject
//
//  Created by gescarcega on 30/04/23.
//

import Foundation

class SearchLocalData {
    
    func getRecentlyViewedMovies() -> [MediaItem] {
        
        let date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        //TODO: Entregable 3 obtener de base de datos
        return [MediaItem(posterPath: "/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg", title: "Harry Potter and the Philosopher's Stone", rating: 7.9, mediaType: .movie, overview: "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard—with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths—and about the villain who's to blame."), MediaItem(posterPath: "/eU1i6eHXlzMOlEq0ku1Rzq7Y4wA.jpg", title: "The Mandalorian", rating: 12.9, mediaType: .tv, releaseDate: date, overview: "After the fall of the Galactic Empire, lawlessness has spread throughout the galaxy. A lone gunfighter makes his way through the outer reaches, earning his keep as a bounty hunter."), MediaItem(posterPath: "/iPg0J9UzAlPj1fLEJNllpW9IhGe.jpg", title: "Daniel Radcliffe", mediaType: .person)]
    }
    
}
