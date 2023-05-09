//
//  MockGeneralTaskCordinator.swift
//  BAZProjectTests
//
//  Created by Ben Frank V. on 31/03/23.
//

import Foundation

class GeneralTaskCoordinatorMock: GeneralTaskCoordinatorProtocol{
    
    var session: URLSessionProtocol
    
    var urlPath: String = ""
    
    var regionValueDefault: String = ""
    
    var languageValueDefault: String = ""
    
    var queryValue: String = ""
    
    var params: [URLQueryItem] = []
    
    var fileName: String = ""
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get<T>(_ urlType: URLType, callback: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            guard let path: String = Bundle(for: type(of: self) ).path(forResource: fileName, ofType: "json") else {
                fatalError("El archivo seleccionado no se encontró")
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decodedData: T = try JSONDecoder().decode(T.self, from: data)
            callback(.success(decodedData))
        } catch {
            callback(.failure(ServiceError.parsingData))
        }
    }
    
    
}
