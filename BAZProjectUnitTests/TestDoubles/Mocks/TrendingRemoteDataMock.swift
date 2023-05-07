//
//  TrendingRemoteDataMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

@testable import BAZProject

class TrendingMediaRemoteDataMock: TrendingMediaRemoteData {
    
    var trending: [MediaDataObject]?
    var popular: [MediaDataObject]?
    var nowplaying: [MediaDataObject]?
    var upcoming: [MediaDataObject]?
    var toprated: [MediaDataObject]?
    var error: Error?
    
    override func getMediaItems(section: TrendingMediaSection) async throws -> [MediaDataObject]? {
        if let error = error {
            throw error
        } else {
            switch section {
            case .trending:
                return trending
            case .nowPlaying:
                return nowplaying
            case .popular:
                return popular
            case .topRated:
                return toprated
            case .upcoming:
                return upcoming
            }
        }
    }
    
}
