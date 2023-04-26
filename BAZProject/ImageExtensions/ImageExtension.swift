//
//  Image Extension.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 10/04/23.
//

import Foundation
import UIKit

extension URL {
    func toImage(completion: @escaping(UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: self), let image = UIImage(data: data) {
                 completion(image)
            } else {
                completion(UIImage(named: "poster"))
            }
        }
    }
}
