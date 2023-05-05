//
//  ResourcesManager.swift
//  BAZProject
//
//  Created by Carlos Garcia on 07/04/23.
//

import UIKit

class ResourcesManager {
    
    /**
     Download data from web service.
     */
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
    }
    
    /**
     Download asset image from web with the URL in tle movie object.
     */
    func downloadImage(from strPath: String, result: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(strPath)") else { result(nil); return }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { result(nil); return }
            DispatchQueue.main.async(execute: {
                result(UIImage(data: data))
            })
        }
    }
}
