//
//  ImageManager.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 08/05/23.
//

import Foundation
import UIKit

class ImageManager {
    static let shared = ImageManager(basePath: "https://image.tmdb.org/t/p/w500")
    private let cache: NSCache = NSCache< NSString, UIImage >()
    private var basePath: String
    
    init(basePath: String) {
        self.basePath = basePath
    }
    
    func getImage(urlImage: String, completion: @escaping (UIImage?) -> Void) {
        
        let path = basePath.appending(urlImage)
        
        guard let defaultImage = UIImage(named: "poster") else {
            completion(UIImage())
            return
        }
        
        guard let url = URL(string: path) else {
            completion(defaultImage)
            return
        }
        
        if let cacheImage = loadFromCache(imageAt: url) {
            completion(cacheImage)
            return
        } else {
            completion(defaultImage)
            downloadImage(imageAt: url){ image in
                if let image = image {
                    completion(image)
                }
            }
        }
    }
    
    func loadFromCache(imageAt url: URL) -> UIImage? {
        let imageKey = url.absoluteString as NSString
        return cache.object(forKey: imageKey)
    }
    
    func downloadImage(imageAt url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else {return}
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
