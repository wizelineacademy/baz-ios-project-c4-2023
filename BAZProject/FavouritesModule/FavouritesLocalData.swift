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
    private var enconder: JSONEncoder
    
    init(udManager: UserDefaultsProtocol = UserDefaults.standard, decoder: JSONDecoder = JSONDecoder(), encoder: JSONEncoder = JSONEncoder()) {
        self.udManager = udManager
        self.decoder = decoder
        self.enconder = encoder
    }
    
    func getFavourites() throws -> [MediaItem]? {
        if let existingData = udManager.getData(forKey: "Recent") {
            return try decoder.decode([MediaItem].self, from: existingData)
        }
        return nil
    }
    
    func removeFavourite(_ item: MediaItem) throws {
        if var elements = try getFavourites(), elements.contains(item) {
            elements.removeAll(where: { $0 == item})
            if elements.count > 0 {
                let data = try enconder.encode(elements)
                udManager.save(data, forKey: "Favourites")
            } else {
                udManager.delete(for: "Favourites")
            }
        }
    }
    
}
