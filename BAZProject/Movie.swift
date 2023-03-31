//
//  Movie.swift
//  BAZProject
//
//

import Foundation
import UIKit

struct Movie: MovieProtocol {

    var id: Int
    var title: String
    var poster_path: String
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var media_type: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: String?
    var release_date: String?
    var video: Bool?
    var vote_average: String?
    var vote_count: String?
    
}

protocol MovieProtocol {
    var id: Int { get }
    var title: String { get }
    var poster_path: String { get }
    var adult : Bool? { get }
    var backdrop_path: String? { get }
    var genre_ids: [Int]? { get }
    var media_type: String? { get }
    var original_language: String? { get }
    var original_title: String? { get }
    var overview: String? { get }
    var popularity: String? { get }
    var release_date: String? { get }
    var video: Bool? { get }
    var vote_average: String? { get }
    var vote_count: String? { get }
}

struct ImageLoader {
    func loadImage(urlData: URL, completion: @escaping (UIImage?) -> Void) {
        let globalQueue = DispatchQueue.global(qos: .utility)
        globalQueue.async {
            guard let data = try? Data(contentsOf: urlData) else {
                DispatchQueue.main.async {
                    let image = UIImage(named: "poster")
                    completion(image)
                }
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image)
            }
        }
    }
}
