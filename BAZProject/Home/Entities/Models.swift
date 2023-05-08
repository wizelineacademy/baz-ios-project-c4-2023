//
//  Models.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation

// TODO: (SDA) Se how changes the implementation
///Model that stores a movie information, such as id, original title, overview, poster path and release date
struct Movie {
    var id: Int?
    var title: String
    var overview: String
    var imagePath: String?
    var additionalInfo: String?
    
    init() {
        self.id = 0
        self.title = ""
        self.overview = ""
        self.imagePath = ""
        self.additionalInfo = ""
    }
}

extension Movie: Decodable {
    ///Enumeration to get rid of underscores
    enum MovieCodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case overview
        case imagePath = "poster_path"
        case aditionalInfo = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try movieContainer.decode(Int.self, forKey: .id)
        title = try movieContainer.decode(String.self, forKey: .title)
        overview =  try movieContainer.decode(String.self, forKey: .overview)
        imagePath = try movieContainer.decodeIfPresent(String.self, forKey: .imagePath)
        additionalInfo = try movieContainer.decode(String.self, forKey: .aditionalInfo)
    }
}

extension Movie: Viewable {
    func getId() -> Int? {
        guard let optionalId = id else {return 0}
        return optionalId
    }
    func getTitle() -> String {
        return title
    }
    func getOverview() -> String {
        return overview
    }
    func getImagePath() -> String? {
        guard let path = imagePath else { return "" }
        return path
    }
    func getAdditionalInfo() -> String? {
        return additionalInfo
    }
}
