//
//  ImageLoader.swift
//  BAZProject
//
//  Created by ksolano on 03/04/23.
//

import UIKit

struct ImageLoader {
    
    // loadImage get the image (poster) when URL is valid.
    // need a urlData for fecth the image of the movie. and returns it.
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
    
    // Get a complete URL, having a base url we can complete de URL with poster_path and return it
    func getURLImage(poster_path: String) -> URL? {
        let base = "https://image.tmdb.org/t/p/w500"
        return URL(string: base + poster_path)
    }
    
}
