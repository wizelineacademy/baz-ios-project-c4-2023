//
//  UIImage.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import UIKit

extension UIImage {
    
    public convenience init?(endpoint: EndpointProtocol, session: RequestSessionProtocol = URLSession.shared) async throws {
        guard let request = endpoint.getRequest() else { return nil }
        let (data, _) = try await session.data(for: request)
        self.init(data: data)
    }
    
}
