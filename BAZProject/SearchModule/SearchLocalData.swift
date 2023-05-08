//
//  SearchLocalData.swift
//  BAZProject
//
//  Created by gescarcega on 30/04/23.
//

import Foundation

class SearchLocalData {
    
    private var udManager: UserDefaultsProtocol
    
    init(udManager: UserDefaultsProtocol = UserDefaults.standard) {
        self.udManager = udManager
    }
    
    func getRecentlySearchedMedia(decoder: JSONDecoder = JSONDecoder()) throws -> [MediaItem]? {
        if let existingData = udManager.getData(forKey: "Recent") {
            return try decoder.decode([MediaItem].self, from: existingData)
        }
        return nil
    }
    
}
