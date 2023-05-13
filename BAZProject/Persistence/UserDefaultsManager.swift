//
//  UserDefaultsManager.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 12/05/23.
//

import Foundation

public class UserDefaultsManager: PersistenceProtocol {
    private let strKeyDefaults = "usrFavoriteList"
    private let usrDefaults: UserDefaults = UserDefaults.standard
    
    public init() {}
    
    public func save<T>(info objInfo: T) where T : StorableObject {
        var arrToSave: [T] = [T]()
        if let arrSaved: [T] = getAll(), !arrSaved.isEmpty {
            arrToSave.append(contentsOf: arrSaved)
        }
        arrToSave.append(objInfo)
        saveList(arrToSave)
    }
    
    public func getAll<T>() -> [T]? where T : StorableObject {
        guard let arrSaved = usrDefaults.data(forKey: strKeyDefaults) else { return nil }
        let decoder = JSONDecoder()
        let arrToReturn = try? decoder.decode([T].self, from: arrSaved)
        return arrToReturn
    }
    
    public func delete<T>(info objInfo: T) where T : StorableObject {
        guard let arrSaved: [T] = getAll(), !arrSaved.isEmpty else { return }
        let arrNew = arrSaved.filter { objInArray in
            return objInArray.id != objInfo.id
        }
        
        saveList(arrNew)
    }
    
    private func saveList<T>(_ arrToSave: [T]) where T : StorableObject {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(arrToSave) {
            usrDefaults.set(data, forKey: strKeyDefaults)
        }
    }
}
