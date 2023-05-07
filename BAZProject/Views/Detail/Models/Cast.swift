//
//  Cast.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 06/05/23.
//

import Foundation

public struct Cast: CellPersonalizedTableViewProtocol {
    
    var strName: String?
    var strProfilePath: String?
    var strCharacter: String?
    
    public init(strName: String? = nil, strProfilePath: String? = nil, strCharacter: String? = nil) {
        self.strName = strName
        self.strProfilePath = strProfilePath
        self.strCharacter = strCharacter
    }
    
    public var strTitle: String {
        return strName ?? ""
    }
    
    public var strOverView: String? {
        return nil
    }
    
    public var strDate: String? {
        return strCharacter
    }
    
    public var urlConfiguration: URLConfiguration? {
        let urlConfiguration = URLConfiguration(strHost: "image.tmdb.org", path: .image(strFile: strProfilePath ?? ""))
        return urlConfiguration
    }
}
