//
//  DecodableMovies.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import Foundation

struct DecodableMovies {
    static let completeData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\",\"poster_path\":\"path//\"}]}").data(using: .utf8)!

    static let missingData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\"}]}").data(using: .utf8)!

    static let extraData = String("{\"results\":[{\"id\":3465,\"title\":\"df_SAWERQ\",\"poster_path\":\"path//\", \"people\":\"john\"}]}").data(using: .utf8)!
}
