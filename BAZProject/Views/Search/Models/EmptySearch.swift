//
//  EmptySearch.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 18/04/23.
//

import Foundation

public struct EmptySearch: CellPersonalizedTableViewProtocol {
    public var strTitle: String {
        return NSLocalizedString("No results found", comment: "No results found")
    }
    public var strOverView: String?
    public var urlConfiguration: URLConfiguration?
    public var strDate: String?
    
    public init() {}
}
