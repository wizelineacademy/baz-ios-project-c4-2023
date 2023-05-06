//
//  DataStubs.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import Foundation

struct DataStubs {
    static let completeData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\",\"poster_path\":\"path//\"}]}").data(using: .utf8)!

    static let missingData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\"}]}").data(using: .utf8)!

    static let extraData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\",\"poster_path\":\"path//\", \"people\":\"john\"}]}").data(using: .utf8)!
    static let imageData: Data = Data(base64Encoded: ImageData.string, options: .ignoreUnknownCharacters)!
    
    static var detailData: Data {
        return Data(fromFile: "MovieDetailResponse")
    }
}


extension Data {
    
    init(fromFile name: String) {
        let file = Bundle().url(forResource: name, withExtension: "json")!
        try! self.init(contentsOf: file)
    }
    
}
