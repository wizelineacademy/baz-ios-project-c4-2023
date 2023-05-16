//
//  FakeMovieApi.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
@testable import BAZProject

/// Tipo enum de respuesta del servidor
enum ResultType{
    case sucess
    case fail(ApiError)
}

///Clase que implementa el mock de   Api MovieDB
/// - parameters:
///    - resultType: tipo de respuesta del servidor
/// - returns:
///   Devuelve un Result con <Modelo, error>
final class FakeMovieApi: GenericAPIProtocol{
   
    ///URLRequest fake
    var movieURLRequest: URLRequest
    
    /// Tipo enum de respuesta del servidor
    private var resultType: ResultType
    
    ///incializador de  Api MovieDB Fake
    /// - parameters:
    ///    - resultType: tipo de respuesta del servidor
    init(resultType: ResultType){
        self.resultType = resultType
        self.movieURLRequest = URLRequest(url: URL(string: "fake/url")!)
    }
    
    /// Este método obtiene la respuesta del servidor
    /// - parameters:
    ///    - request: Request  a consumir
    /// - returns:
    ///   Devuelve un Result con <Modelo, error> Fake
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
    
    /// Este método realiza la decodificación de data
    /// - parameters:
    ///    - data: información a decodificar
    ///    -  decoder: instancia de JSONDecoder
    /// - returns:
    ///     - retorna el objeto decodificado
    func decode<T: Decodable>(data: Data, decoder: JSONDecoder = JSONDecoder()) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
}


extension FakeMovieApi{
    
    ///   Devuelve un Result con <Modelo, error> Fake  apartir de un archivo
    private func getData(json file: String) -> Data {
        guard let path: String = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else {
            fatalError("No existe el archivo")
        }
        let data: Data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
    
   
}
