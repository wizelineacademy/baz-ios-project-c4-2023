//
//  MoviesViewModels.swift
//  BAZProject
//
//  Created by nmorenoa on 30/03/23.
//

import Foundation
import UIKit

struct MoviesViewModels: MovieData{
    var title: String
    var poster_path: String
    func getImage(completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster_path)") else { return }
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            if let data = try? Data(contentsOf: url){
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image ?? UIImage())
                }
            }
        }
    }
}

protocol MovieData {
    var title: String { get }
    var poster_path: String { get }
    func getImage(completion: @escaping(UIImage) ->())
}
