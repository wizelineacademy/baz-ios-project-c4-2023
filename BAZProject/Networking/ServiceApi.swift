//
//  ServiceApi.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 27/03/23.
//

import Foundation

protocol ServiceApiProtocol : AnyObject{
    func serviceFinished(withResult result : Result<[String : Any], Error>)
}

class ServiceApi{
    
    private let strBaseURL : String = "https://api.themoviedb.org/3"
    private let strTokenKey : String = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    private weak var serviceDelegate : ServiceApiProtocol?
    
    init(serviceDelegate: ServiceApiProtocol? = nil) {
        self.serviceDelegate = serviceDelegate
    }
    
    func search(forPath strPath : String){
        guard let url = URL(string: configureURL(forPath: strPath)) else {
            let error = NSError(domain: "", code: -616)
            serviceDelegate?.serviceFinished(withResult: .failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: .init(url: url)) {[weak self] data, response, error in
            var dctResponse : [String : Any] = [String : Any]()
            defer {
                self?.serviceDelegate?.serviceFinished(withResult: .success(dctResponse))
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String : Any]
            else {
                self?.serviceDelegate?.serviceFinished(withResult: .failure(error!))
                return
            }
            dctResponse = json

        }.resume()
    }
    
    func configureURL(forPath strPath : String) -> String{
        return "\(strBaseURL)\(strPath)\(strTokenKey)"
    }
    
    
}
