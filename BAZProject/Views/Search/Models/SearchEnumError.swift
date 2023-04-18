//
//  SearchEnumError.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 17/04/23.
//

import Foundation
 
public enum SearchEnumError {
    case invalidString
    case serviceProblem
    case noResultsFound
    
    public func getString() -> String {
        switch self {
        case .invalidString:
            return NSLocalizedString("Please, provide a term to search.", comment: "Please, provide a term to search.")
        case .serviceProblem:
            return NSLocalizedString("The service didn't respond", comment: "The service didn't respond")
        case .noResultsFound:
            return NSLocalizedString("No results found", comment: "No results found")
        }
    }
}
