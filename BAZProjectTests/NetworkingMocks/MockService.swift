//
//  MockService.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 13/04/23.
//

import Foundation
import BAZProject

class MockService<T: Decodable>: NetworkingProtocol {
    var configuration: URLConfiguration
    private var caseToTest: MockCasesToTest
    
    init(configuration: URLConfiguration, caseToTest: MockCasesToTest) {
        self.configuration = configuration
        self.caseToTest = caseToTest
    }
    
    func search<T>(withCompletionHandler handler: @escaping (Result<T, BAZProject.ErrorApi>) -> Void) where T : Decodable {
        switch caseToTest {
        case .testError(let errorExpected):
            handler(.failure(errorExpected))
        case .testSuccess(let strFileName):
            let url = Bundle(for: MockService.self).url(forResource: strFileName, withExtension: "json")
             guard let dataURL = url, let data = try? Data(contentsOf: dataURL), let json = try? JSONDecoder().decode(T.self, from: data) else {
                 handler(.failure(.badJSON))
                 return
             }
            handler(.success(json))
        }
    }
    
}

enum MockCasesToTest {
    case testError(ErrorApi)
    case testSuccess(String)
}
