//
//  SearchRemoteDataMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 01/05/23.
//

@testable import BAZProject


class SearchRemoteDataMock: SearchRemoteData {
    
    var mediaObject: [MediaDataObject]?
    
    override func searchMedia(_ searchText: String) async throws -> [MediaDataObject]? {
        return mediaObject
    }
    
}
