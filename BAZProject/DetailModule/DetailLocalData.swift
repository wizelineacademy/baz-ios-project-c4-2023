//
//  DetailLocalData.swift
//  BAZProject
//
//  Created by gescarcega on 07/05/23.
//

import Foundation

class DetailLocalData {
    
    private var userDefaults: UserDefaultsProtocol
    private var encoder: JSONEncoder
    private var decoder: JSONDecoder
    
    init(userDefaults: UserDefaultsProtocol = UserDefaults.standard, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }

    
    func getExistingItems(key: String) throws -> [MediaItem]? {
        if let existingData = userDefaults.getData(forKey: key) {
            return try decoder.decode([MediaItem].self, from: existingData)
        }
        return nil
    }
    
    func favouriteExistsIn(_ existingItems: [MediaItem], item: MediaItem) -> Bool {
        for existingItem in existingItems {
            if existingItem.id == item.id && existingItem.title == item.title && existingItem.releaseDate == item.releaseDate && existingItem.mediaType == existingItem.mediaType {
                return true
            } else {
                continue
            }
        }
        return false
    }
    
    func saveOrDeleteFavourite(item: MediaItem) throws {
        var encodedData: Data?
        if let existingElements = try getExistingItems(key: "Favourites") {
            var elements = existingElements
            if !favouriteExistsIn(existingElements, item: item) {
                elements.append(item)
            } else {
                elements.removeAll(where: { $0 == item})
            }
            encodedData = try encoder.encode(elements)
        } else {
            encodedData = try encoder.encode([item])
        }
        userDefaults.save(encodedData, forKey: "Favourites")
    }
    
    func saveRecentlySearched(_ item: MediaItem) throws {
        if let existingElements = try getExistingItems(key: "Recent") {
            var elements = existingElements
            if !favouriteExistsIn(existingElements, item: item) {
                elements.append(item)
                let data = try encoder.encode(elements)
                userDefaults.save(data, forKey: "Recent")
            }
        } else {
            let encoded = try encoder.encode([item]) 
            userDefaults.save(encoded, forKey: "Recent")
        }
    }
    
    
}
