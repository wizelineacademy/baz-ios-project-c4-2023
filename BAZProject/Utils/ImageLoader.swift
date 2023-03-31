//
//  ImageLoader.swift
//  BAZProject
//
//  Created by jehernandezg on 31/03/23.
//

import Foundation
import UIKit

/// Protocol used to get a UIImage from a remote URL asynchronously
protocol ImageLoadable {
    func loadIamge(from url: URL, callBack: @escaping (UIImage?) -> Void)
}

/// structure that is decoupled by conforming to ImageLoadable protocol
struct ImageLoader: ImageLoadable {
    
    private let global = DispatchQueue.global()
    
    func loadIamge(from url: URL, callBack: @escaping (UIImage?) -> Void) {
        global.async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                let img = UIImage(data: data ?? Data())
                callBack(img ?? UIImage())
            }
        }
    }
}
