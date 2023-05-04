//
//  Helpers.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import Foundation
@testable import BAZProject

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyz"
    return String((0..<length).map{ _ in letters.randomElement()! })
}

func generateMovies(_ count: Int) -> [Movie] {
    guard count > 0 else { return [] }
    
    var allMovies: [Movie] = []
    
    for _ in 0..<count {
        let id = Int.random(in: 9..<1000)
        
        let nameLength = Int.random(in: 9..<20)
        let name = randomString(length: nameLength)
        
        let randThumbnail = Int.random(in: 0...9)
        let thumbnail = "https://picsum.photos/300/10\(randThumbnail)"
        
        let description = randomString(length: Int.random(in: 100...150))
        
        let movie = Movie(id: id, title: name, posterPath: thumbnail, overview: description, voteAverage: Float.random(in: 0...10), releaseDate: randomDate())
        allMovies.append(movie)
    }
    
    return allMovies
}

func randomDate() -> String {
    let randomYear = Int(arc4random_uniform(20)) + 2000
    let randomMonth = Int(arc4random_uniform(12)) + 1
    let randomDay = Int(arc4random_uniform(28)) + 1
    let randomDateComponents = DateComponents(year: randomYear, month: randomMonth, day: randomDay)
    let randomDate = Calendar.current.date(from: randomDateComponents)!
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateString = dateFormatter.string(from: randomDate)
    
    return dateString
}
