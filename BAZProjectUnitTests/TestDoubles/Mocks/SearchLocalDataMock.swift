//
//  SearchLocalDataMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 01/05/23.
//

@testable import BAZProject

final class SearchLocalDataMock: SearchLocalData {
    
    var items: [MediaItem]?
    
    override func getRecentlySearchedMedia() -> [MediaItem]? {
        return items
    }

}
