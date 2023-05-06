//
//  Movie.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 24/04/23.
//

import Foundation

struct MovieApiResponse: Decodable {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies =  try container.decode([Movie].self, forKey: .movies)
    }
}

struct CastResponse: Decodable {
    var id: Int
    var actors: [Actor]
    
    enum CastResponseCodingKeys: String, CodingKey {
        case id
        case actors = "cast"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CastResponseCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        actors = try container.decode([Actor].self, forKey: .actors)
    }
}

struct Actor {
    var id: Int?
    var title: String
    var overview: String
    var imagePath: String?
    var additionalInfo: String?
    var movies: [Movie]?
}

extension Actor: Decodable {
    enum ActorCodingKeys: String, CodingKey {
        case id
        case title = "name"
        case overview = "original_name"
        case imagePath = "profile_path"
        case additionalInfo = "character"
        case movies = "known_for"
    }
    
    init(from decoder: Decoder) throws {
        let actorContainer = try decoder.container(keyedBy: ActorCodingKeys.self)
        
        id = try actorContainer.decode(Int.self, forKey: .id)
        title = try actorContainer.decode(String.self, forKey: .title)
        overview = try actorContainer.decode(String.self, forKey: .overview)
        imagePath = try actorContainer.decodeIfPresent(String.self, forKey: .imagePath)
        additionalInfo = try actorContainer.decodeIfPresent(String.self, forKey: .additionalInfo)
        movies = try actorContainer.decodeIfPresent([Movie].self, forKey: .movies)
    }
    
    func getMovies() -> [Movie]? {
        guard let movies = movies else { return [] }
        return movies
    }
}

extension Actor: Viewable {
    func getId() -> Int? {
        guard let optionalId = id else {return 0}
        return optionalId
    }
    func getTitle() -> String {
        return title
    }
    func getOverview() -> String {
        return overview
    }
    func getImagePath() -> String? {
        guard let optionalPath = imagePath else {return ""}
        return optionalPath
    }
    func getAdditionalInfo() -> String? {
        guard let optionalInfo = additionalInfo else {return ""}
        return optionalInfo
    }
}

struct ReviewsResponse: Decodable {
    var id: Int
    var reviews: [Review]
    
    enum ReviewResponseCodingKeys: String, CodingKey {
        case id
        case reviews = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ReviewResponseCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        reviews = try container.decode([Review].self, forKey: .reviews)
    }
}

struct Review: Decodable {
    var id: Int?
    var title: String
    var overview: String
    //TODO: Modify to get the image path from author details
    var imagePath: String?
    var additionalInfo: String?
//    var reviewId: String
    
    enum ReviewCodingKeys: String, CodingKey {
//        case id
        case title = "author"
        case overview = "content"
        case imagePath
        case additionalInfo = "created_at"
        case reviewId = "id"
    }
    
    init(from decoder: Decoder) throws {
        let reviewContainer = try decoder.container(keyedBy: ReviewCodingKeys.self)
        
//        id = try reviewContainer.decodeIfPresent(Int.self, forKey: .id)
        title = try reviewContainer.decode(String.self, forKey: .title)
        overview = try reviewContainer.decode(String.self, forKey: .overview)
        imagePath = try reviewContainer.decodeIfPresent(String.self, forKey: .imagePath)
        additionalInfo = try reviewContainer.decodeIfPresent(String.self, forKey: .additionalInfo)
//        reviewId = try reviewContainer.decode(String.self, forKey: .reviewId)
    }
}

extension Review: Viewable {
    func getId() -> Int? {
        return 0
    }
    func getTitle() -> String {
        return title
    }
    func getOverview() -> String {
        return overview
    }
    //TODO: Modify to get image path from author details
    func getImagePath() -> String? {
        return ""
    }
    func getAdditionalInfo() -> String? {
        return additionalInfo
    }
}

//struct MediaApiResponse: Decodable {
//    let results: [Viewable]
//    
//    private enum MediaCodingKeys: String, CodingKey {
//        case results
//    }
//    
//    init(from decoder: Decoder) throws {
//        let firstContainer = try decoder.container(keyedBy: MediaCodingKeys.self)
//        
//        let results = try firstContainer.decode([Viewable].self, forKey: .results)
//        var allItems: [Viewable] = []
//        var nestedUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .results)
//        
//        while !nestedUnkeyedContainer.isAtEnd {
//            let nestedContainer = try nestedUnkeyedContainer.nestedContainer(keyedBy: MediaCodingKeys.self)
//            
//            if let _ = try? nestedContainer.decode(Movie.self, forKey: .results){
//                let movie = try nestedContainer.decode(Movie.self, forKey: .results)
//                allItems.append(movie)
//            }
//        }
//        results = allItems
//    }
//}
//
//private enum InnerCodingKeys: String, CodingKey {
//    case type = "media_type"
//}


