//
//  DataStubs.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import Foundation

class DataStubs {
    
    static let completeData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\",\"poster_path\":\"path//\"}]}").data(using: .utf8)!

    static let missingData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\"}]}").data(using: .utf8)!

    static let extraData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\",\"poster_path\":\"path//\", \"people\":\"john\"}]}").data(using: .utf8)!
    static let imageData: Data = Data(base64Encoded: ImageData.string, options: .ignoreUnknownCharacters)!
    
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
    
}
