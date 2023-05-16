//
//  UserDefaultFake.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 13/05/23.
//

import Foundation

@testable import BAZProject

class UserDefaultsFake: UserDefaultsProtocol {
    
    ///Dicccionario con que se inicializa UserDefaultsFake
    var fakeMoview: [Int : Movie]?
    
    ///incializador de  UserDefaultsFake
    /// - parameters:
    ///    - fakeMoview: Dicccionario con que se inicializa UserDefaultsFake
    init(fakeMoview: [Int : Movie]?){
        self.fakeMoview = fakeMoview
    }
    
    ///metodo que regresa una fake Data de un UserDefault
    /// - parameters:
    ///    - forKey: Nombre de la llave
    func data(forKey defaultName: String) -> Data? {
        return Data()
    }
    
    ///metodo que regresa una fake Data de un UserDefault
    /// - returns:
    ///   Devuelve un Diccionario  con llave y el modelo de Movies
    func returnMoviesDictionary() -> [Int : BAZProject.Movie]? {
        return fakeMoview
    }
    
    ///metodo que regresa una fake Data de un UserDefault
    /// - parameters:
    ///    - _: valor de la llave
    ///    - forKey: llave del diccionario
    func setValue(_ value: Any?, forKey key: String) {
        guard let movie = value as? Movie,
              let iKey = Int(key) else { return }
        fakeMoview = [iKey : movie]
    }
    
}
