//
//  TrendingRemoteDataMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

@testable import BAZProject

class TrendingMediaRemoteDataMock: TrendingMediaRemoteData {
    
    var mediaItems: [MediaDataObject]?
    var error: Error?
    
    override func getMediaItems() async throws -> [MediaDataObject]? {
        if let error = error {
            throw error
        } else {
            return mediaItems
        }
    }
    
}
