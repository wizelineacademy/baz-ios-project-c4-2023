//
//  UIImage+Extensions.swift
//  BAZProject
//
//  Created by jmgarciaca on 21/04/23.
//

import UIKit

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}
