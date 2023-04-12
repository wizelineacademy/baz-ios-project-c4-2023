//
//  SearchRemoteDataManager.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 10/04/23.
//  
//

import Foundation

class SearchRemoteDataManager: SearchRemoteDataManagerInputProtocol {
    func fetchSearchResults(with query: String) {
        print("Busqueda")
    }
    
    
    private var service: ServiceProtocol
    weak var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
}
