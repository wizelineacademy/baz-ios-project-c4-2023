//
//  SearchLocalDataMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 01/05/23.
//

import Foundation
@testable import BAZProject

final class SearchLocalDataMock: SearchLocalData {
    
    var items: [MediaItem]?
    
    override func getRecentlySearchedMedia(decoder: JSONDecoder) throws -> [MediaItem]? {
        return items
    }

}
