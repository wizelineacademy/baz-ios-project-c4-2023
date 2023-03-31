//
//  ImageLoader.swift
//  BAZProject
//
//  Created by jehernandezg on 31/03/23.
//

import Foundation
import UIKit

/// Protocol to is used to get a UIImage from remote url
protocol ImageLoadable {
    func loadIamge(from url: URL, callBack: @escaping (UIImage?) -> Void)
}

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
