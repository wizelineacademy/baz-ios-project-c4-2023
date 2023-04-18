//
//  ImageLoader.swift
//  BAZProject
//
//  Created by jmgarciaca on 31/03/23.
//

import Foundation
import UIKit

struct ImageLoader {
    private let queue = DispatchQueue(label: "com.imageQueue")
    
    func getImage(from url: URL, completion: @escaping (UIImage) -> Void) {
        
        queue.async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else if let image = UIImage(named: "poster") {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}
