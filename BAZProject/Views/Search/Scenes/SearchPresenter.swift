//
//  SearchPresenter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 16/04/23.
//

import Foundation

protocol SearchPresentationLogic {
    var view: SearchDisplayLogic? { get }
}

class SearchPresenter {
    weak var view: SearchDisplayLogic?
}

extension SearchPresenter: SearchPresentationLogic {
    
}
