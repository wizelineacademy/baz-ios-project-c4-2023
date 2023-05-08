//
//  ServiceApi.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//
import Foundation

class ServiceAPI: Service {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    ///Generico para consulta de servicio. Consulta e intenta parsear datos
    func get<T: Decodable>(_ endpoint: URL, callback: @escaping (Result<T, Error>) -> Void) {
        let request = URLRequest(url: endpoint)
        DispatchQueue.global().async {
            let task = self.session.performDataTask(with: request) { (data, response, error) in

                if let error: Error = error { // manejo de errores
                    callback(.failure(error))
                    return
                }

                guard let data: Data = data else {
                    callback(.failure(ServiceError.noData))
                    return
                }
                
                do {
                    let decodedData: T = try JSONDecoder().decode(T.self, from: data) // decodificacion de los datos
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error))
                }
            }
            task.resume()
        }
    }
}
