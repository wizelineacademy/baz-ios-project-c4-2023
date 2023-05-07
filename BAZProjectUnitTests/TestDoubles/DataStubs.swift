//
//  DataStubs.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import Foundation
@testable import BAZProject

class DataStubs {
    
    static let completeData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\",\"poster_path\":\"path//\"}]}").data(using: .utf8)!

    static let missingData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\"}]}").data(using: .utf8)!

    static let extraData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\",\"poster_path\":\"path//\", \"people\":\"john\"}]}").data(using: .utf8)!
    static let imageData: Data = Data(base64Encoded: ImageData.string, options: .ignoreUnknownCharacters)!
    
    static let singleMovieMediaData = MediaItem(id: 18, posterPath: "/fPtlCO1yQtnoLHOwKtWz7db6RGU.jpg", title: "The Fifth Element", rating: 5.643, mediaType: .movie, releaseDate: DateFormatter.getDate(from: "1997-07-02"))
    
    static let singleTVMediaData = MediaItem(id: 18, posterPath: "/fwSw4fl08MVl5w6Q9lVUGIFkZQ2.jpg", title: "W*A*L*T*E*R", rating: 5.6, mediaType: .tv, releaseDate: DateFormatter.getDate(from: "1984-07-17"))
    
    static let singlePersonMediaData = MediaItem(id: 132, posterPath: "/pBXNUejSwDHfWCD9GgmvRbIPBdb.jpg", title: "Scott MacDonald", rating: nil, mediaType: .person, releaseDate: nil)
    
    var movieDetailData: Data {
        let bundle = Bundle(for: type(of: self))
        let file = bundle.url(forResource: "MovieDetailResponse", withExtension: "json")!
        return try! Data(contentsOf: file)
    }
    
    var tvDetailData: Data {
        let bundle = Bundle(for: type(of: self))
        let file = bundle.url(forResource: "TVDetailResponse", withExtension: "json")!
        return try! Data(contentsOf: file)
    }
    
    var personDetailData: Data {
        let bundle = Bundle(for: type(of: self))
        let file = bundle.url(forResource: "PersonDetailResponse", withExtension: "json")!
        return try! Data(contentsOf: file)
    }
    
    static let personDetailDictionary: [DetailSection: [AnyHashable]] = [.overview: [OverviewModel(largeTitle: "Scott MacDonald", smallSubtitle: "Birth: 1/1/59", image: "/pBXNUejSwDHfWCD9GgmvRbIPBdb.jpg", description: "biography", defaultImage: nil)],
                                                                  .filmography: [MediaItem(id: 27318, posterPath: "/sXOATwGluNbb9ezfG6DvXCiXvJp.jpg", title: "Jack Frost", rating: 5.14, mediaType: .movie, releaseDate: DateFormatter.getDate(from: "1997-11-18"))]]
    static let movieDetailDictionary: [DetailSection: [AnyHashable]] =
    [.overview: [OverviewModel(largeTitle: "The Fifth Element", smallSubtitle: "1997", image: "/fPtlCO1yQtnoLHOwKtWz7db6RGU.jpg", description: "fifthElement", defaultImage: "poster")],
     .cast: [DetailCastMember(actor: MediaItem(id: 62, posterPath: "/caX3KtMU42EP3VLRFFBwqIIrch5.jpg", title: "Bruce Willis", rating: nil, mediaType: .person, releaseDate: nil), character: "Korben Dallas")],
     .similar: [MediaItem(id: 2486, posterPath: "/k8f8WZjTzZ6TJYrKpyayCB4zKlw.jpg", title: "Eragon", rating: 5.066, mediaType: .movie, releaseDate: DateFormatter.getDate(from: "2006-12-14"))],
     .recommended: [MediaItem(id: 607, posterPath: "/uLOmOF5IzWoyrgIF5MfUnh5pa1X.jpg", title: "Men in Black", rating: 7.18, mediaType: .movie, releaseDate: DateFormatter.getDate(from: "1997-07-02"))],
     .reviews: [DetailReview(author: "GeekMasher", content: "best movies", date: DateFormatter.getDate(from: "2021-06-23T15:57:20.936Z", format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"))]
    ]
    
    static let tvDetailDictionary: [DetailSection: [AnyHashable]] =
    [.overview: [OverviewModel(largeTitle: "W*A*L*T*E*R", smallSubtitle: "1984 - 1999", image: "/fwSw4fl08MVl5w6Q9lVUGIFkZQ2.jpg", description: "wally", defaultImage: "poster")],
     
     .cast: [DetailCastMember(actor: MediaItem(id: 89547, posterPath: "/3klT2K1UGl1wvmHKuDcSPuUFasV.jpg", title: "Brian Dobson", rating: nil, mediaType: .person, releaseDate: nil), character: "Ben Grimm (voice)")],
     
     .similar: [MediaItem(id: 87415, posterPath: "/pah40fuJA2tZBcY1rhvpSlj0Ys1.jpg", title: "Shadow", rating: 6.4, mediaType: .tv, releaseDate: DateFormatter.getDate(from: "2019-03-08"))],
     
     .recommended: [MediaItem(id: 11294, posterPath: "/10XpD4aEOExWcOg9bxCA28NNsMQ.jpg", title: "Kitchen Nightmares", rating: 7.48, mediaType: .tv, releaseDate: DateFormatter.getDate(from: "2007-09-19"))],
     
        .reviews: [DetailReview(author: "Peter89Spencer", content: "liked", date: DateFormatter.getDate(from: "2021-06-23T15:58:47.976Z", format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"))]
    ]
    
}
