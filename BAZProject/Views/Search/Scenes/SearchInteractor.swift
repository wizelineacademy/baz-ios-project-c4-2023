//
//  SearchInteractor.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 16/04/23.
//

import Foundation

protocol SearchBusinessLogic {
    var presenter: SearchPresentationLogic? { get }
}

class SearchInteractor {
    var presenter: SearchPresentationLogic?
}

extension SearchInteractor: SearchBusinessLogic {
    
}
