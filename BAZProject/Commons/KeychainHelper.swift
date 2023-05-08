//
//  KeychainHelper.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import Foundation

final class KeychainHelper {
    
    static let standard = KeychainHelper()
    private init() {}
    
    ///Funcion para guardar un dato
    func save(_ data: Data, service: String, account: String) {
        let query = [kSecValueData: data, kSecClass: kSecClassGenericPassword, kSecAttrService: service, kSecAttrAccount: account] as CFDictionary
                let status = SecItemAdd(query, nil)
        if status != errSecSuccess {
            print("Error: \(status)")
        }
    }
    
    ///Funcion para leer un dato
    func read(service: String, account: String) -> Data? {
        let query = [kSecAttrService: service, kSecAttrAccount: account, kSecClass: kSecClassGenericPassword, kSecReturnData: true
        ] as CFDictionary
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return (result as? Data)
    }
    
    // MARK: - Genericos de keyChain
    ///Funcion generica  guardar una estructura
    func genericSave<T>(_ item: T, service: String, account: String) where T : Codable {
        do {
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
        } catch {
            assertionFailure("\(error)")
        }
    }
    
    ///Funcion generica  leer una estructura
    func genericRead<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        // Read item data from keychain
        guard let data = read(service: service, account: account) else { return nil } // Decode JSON data to object
        
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("\(error)")
            return nil
        }
    }
}
