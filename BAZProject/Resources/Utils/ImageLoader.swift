//
//  ImageLoader.swift
//  BAZProject
//
//  Created by jmgarciaca on 31/03/23.
//

import UIKit

struct ImageLoader {
    
    ///Private queue for loading images from the network.
    private let queue = DispatchQueue(label: "com.imageQueue")
    
    /// Loads an image from a given URL and returns it asynchronously.
    /// - Parameters:
    ///    - url: The URL from which to fetch the image.
    ///    - completion: The completion block to call once the image has been loaded successfully.
    func getImage(from url: URL, completion: @escaping (UIImage) -> Void) {
        
        queue.async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}
