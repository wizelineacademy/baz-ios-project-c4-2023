//
//  TrendingBarDispatchDecorator.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

final class TrendingBarDispatchDecorator: Service {
    var session: URLSessionProtocol

    private let decoratee: Service

    init(decoratee: Service) {
        self.decoratee = decoratee
        self.session = decoratee.session
    }

    func get<T: Decodable>(_ endpoint: Endpoint, callback: @escaping (Result<T,Error>) -> Void) {
        decoratee.get(endpoint) { [weak self] result in
            self?.guaranteeMainThread {
                callback(result)
            }
        }
    }

    func fetchImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        decoratee.fetchImageData(urlString: urlString) { [weak self] data in
            self?.guaranteeMainThread {
                completion(data)
            }
        }
    }

    private func guaranteeMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}
