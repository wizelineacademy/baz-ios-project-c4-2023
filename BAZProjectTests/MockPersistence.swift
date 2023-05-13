//
//  MockPersistence.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 12/05/23.
//

import Foundation
import BAZProject

final class MockPersistence: PersistenceProtocol {
    private var arrSaved: [StorableObject] = [StorableObject]()
    
    func save<T>(info objInfo: T) where T : StorableObject {
        arrSaved.append(objInfo)
    }
    
    func getAll<T>() -> [T]? where T : StorableObject {
        return arrSaved as? [T]
    }
    
    func delete<T>(info objInfo: T) where T : StorableObject {
        arrSaved = arrSaved.filter({ obj in
            return obj.id != objInfo.id
        })
    }
}
