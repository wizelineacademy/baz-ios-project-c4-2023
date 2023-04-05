//
//  ImageLoader.swift
//  BAZProject
//
//  Created by jehernandezg on 31/03/23.
//

import UIKit

/// Protocol used to get a UIImage from a remote URL asynchronously
protocol ImageLoadable {
    func loadImage(from url: URL, callBack: @escaping (UIImage?) -> Void)
}

/// structure that is decoupled by conforming to ImageLoadable protocol
struct ImageLoader: ImageLoadable {
    
    private let global = DispatchQueue.global()
    
    ///Function to transform the url image to a UIImage and return it
    ///Parama url: The url image
    ///Param callBack: The completion whit image
    ///Return the image from data
    func loadImage(from url: URL, callBack: @escaping (UIImage?) -> Void) {
        global.async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                let img = UIImage(data: data ?? Data())
                callBack(img ?? UIImage())
            }
        }
    }
}
