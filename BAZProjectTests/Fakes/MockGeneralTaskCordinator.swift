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
    
    var fileName: String = ""
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get<T>(callback: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        do {
            let data = try Data(contentsOf: URL(string: fileName)!)
            let decodedData: T = try JSONDecoder().decode(T.self, from: data)
            callback(.success(decodedData))
        } catch {
            callback(.failure(ServiceError.parsingData))
        }
    }
    
    
}
