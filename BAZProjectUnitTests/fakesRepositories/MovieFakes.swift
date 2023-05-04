//
//  MovieFakes.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import Foundation
@testable import BAZProject

class MovieFakes: MovieRepository {
    
    func getCast(movieID: Int, completion: @escaping ([Actor]) -> Void) {
        let actors = generateActors(4)
        completion(actors)
    }


    func getReviews(movieID: Int, completion: @escaping ([Review]) -> Void) {
        let reviews = generateReviews(3)
        completion(reviews)
    }
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    private func generateActors(_ count: Int) -> [Actor] {
        guard count > 0 else { return [] }
        
        var allActors: [Actor] = []
        
        for _ in 0..<count {

            let nameLength = Int.random(in: 9..<15)
            let name = randomString(length: nameLength)
            let character = randomString(length: nameLength)

            let randThumbnail = Int.random(in: 0...9)
            let thumbnail = "https://picsum.photos/300/10\(randThumbnail)"

            let actor = Actor(name: name, profilePath: thumbnail, character: character)
            allActors.append(actor)
        }
        
        return allActors
    }
    
    private func generateReviews(_ count: Int) -> [Review] {
        guard count > 0 else { return [] }
        
        var allReviews: [Review] = []
        
        for _ in 0..<count {

            let name = randomString(length: Int.random(in: 9..<15))
            let content = randomString(length: Int.random(in: 9..<200))

            let review = Review(author: name, content: content, rating: Int.random(in: 9..<10), createdAt: randomDate())
            allReviews.append(review)
        }
        
        return allReviews
    }
    
    private func randomDate() -> String {
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
}
