//
//  FavouritesLocalData.swift
//  BAZProject
//
//  Created by gescarcega on 08/05/23.
//

import Foundation

class FavouritesLocalData {
    
    private var udManager: UserDefaultsProtocol
    private var decoder: JSONDecoder
    
    init(udManager: UserDefaultsProtocol = UserDefaults.standard, decoder: JSONDecoder = JSONDecoder()) {
        self.udManager = udManager
        self.decoder = decoder
    }
    
    func getFavourites() throws -> [MediaItem]? {
        if let existingData = udManager.getData(forKey: "Recent") {
            return try decoder.decode([MediaItem].self, from: existingData)
        }
        return nil
    }
}
