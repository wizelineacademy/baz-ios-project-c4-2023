//
//  EmptySearch.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 18/04/23.
//

import Foundation

public struct EmptySearch: ImageTextTableViewProtocol {
    
    public var strTitle: String {
        return NSLocalizedString("No results found", comment: "No results found")
    }
    public var strOverView: String {
        return ""
    }
    public var urlConfiguration: URLConfiguration {
        return URLConfiguration(path: .noPath)
    }
    
    public init() {}
    
}
