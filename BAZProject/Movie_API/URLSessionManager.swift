//
//  URLSessionManager.swift
//  BAZProject
//
//  Created by Carlos Garcia on 19/04/23.
//

import Foundation

class URLSessionManager {
    
    static let strServerURL: String = "https://api.themoviedb.org"
    
    static func request<Request: Encodable, Response: Decodable>(strURL: String, body: Request? = nil, completion: @escaping (_ response: Response?, _ error: NSError?) -> Void) {
        guard let url = URL(string: "\(strServerURL)\(strURL)&api_key=\(APIConfig.accessKey)")
        else {
            return completion(nil, NSError(domain: "URLSessionManager.URLError", code: -1) )
        }
//        print("URL:", url.absoluteString)
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard
                    let data = data,
//                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let response = try? JSONDecoder().decode(Response.self, from: data)
                else {
                    DispatchQueue.main.async(execute: {
                        completion(nil, NSError(domain: "URLSessionManager.JSONError", code: -2))
                    })
                    return
                }
//                print(json)
                DispatchQueue.main.async(execute: {
                    completion(response, nil)
                })
            }.resume()
        }
    }
    
}


