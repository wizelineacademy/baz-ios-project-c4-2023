//
//  FakeMovieApi.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
@testable import BAZProject

enum ResultType{
    case sucess
    case fail(ApiError)
}


final class FakeMovieApi: GenericAPIProtocol{
    var movieURLRequest: URLRequest
    private var resultType: ResultType
    
    init(resultType: ResultType){
        self.resultType = resultType
        self.movieURLRequest = URLRequest(url: URL(string: "fake/url")!)
    }
    
    func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping (Result<T?, Error>) -> Void) {
        switch resultType {
        case .sucess:
            if let decodedResponse: T = self.decode(data: getData(json: "movieResult")) {
                completionHandler(.success(decodedResponse))
            }
        case .fail(let error):
            completionHandler(.failure(error))
        }
    }

    func decode<T: Decodable>(data: Data, decoder: JSONDecoder = JSONDecoder()) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
}


extension FakeMovieApi{
    private func getData(json file: String) -> Data {
        guard let path: String = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else {
            fatalError("No existe el archivo")
        }
        let data: Data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
    
   
}
