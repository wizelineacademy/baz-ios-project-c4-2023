//
//  CastService.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 06/05/23.
//

import Foundation

public struct CastResults: Codable {
    var id: Int?
    var cast: [CastService]?
}

public struct CastService: Codable {
    var name: String?
    var profile_path: String?
    var character: String?
}

extension CastService {
    func createCastApp() -> Cast {
        return Cast(strName: name, strProfilePath: profile_path, strCharacter: character)
    }
}
