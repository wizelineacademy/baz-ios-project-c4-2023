//
//  UIImage.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import UIKit

extension UIImage {
    
    public convenience init?(download path: String) async throws {
        guard let request = ImageEndpoint(path: path).getRequest() else { return nil }
        let (data, _) = try await URLSession.shared.data(for: request)
        self.init(data: data)
    }
    
}
