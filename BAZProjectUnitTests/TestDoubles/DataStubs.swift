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
    
    static let singleTVMediaData = MediaItem(id: 18, posterPath: "/eKcpqTutiVxQeAPbwupjSV5DXE.jpg", title: "W*A*L*T*E*R", rating: 5.6, mediaType: .tv, releaseDate: DateFormatter.getDate(from: "1984-07-17"))
    
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
    
}
