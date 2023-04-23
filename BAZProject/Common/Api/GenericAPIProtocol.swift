//
//  GenericAPI.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 19/04/23.
//

import Foundation
///Protocolo para implementar una llamada al Api MovieDB
protocol GenericAPIProtocol {
    func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping (Result<T?, Error>) -> Void)
    func decode<T: Decodable>(data: Data, decoder: JSONDecoder) -> T?
}

extension GenericAPIProtocol {
    /// Este método obtiene la respuesta del servidor
    /// - parameters:
    ///    - request: Request  a consumir
    /// - returns:
    ///   Devuelve un Result con <Modelo, error>
    func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping (Result<T?, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(ApiError.defaultError))
                return
            }
            if let decodedResponse: T = self.decode(data: data) {
                DispatchQueue.main.async {
                    completionHandler(.success(decodedResponse))
                }
                return
            }
        }.resume()
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
