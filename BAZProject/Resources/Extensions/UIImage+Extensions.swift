//
//  UIImage+Extensions.swift
//  BAZProject
//
//  Created by jmgarciaca on 21/04/23.
//

import UIKit

extension UIImage {

    /// Returns the base64-encoded representation of the receiver's JPEG data.
    /// - Returns: The base64-encoded string, or nil if the receiver's JPEG data could not be converted.
    /// - Note: The method returns the base64 representation of the data with a compression quality of 1.0.
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}
