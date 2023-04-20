//
//  SearchPresenter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 16/04/23.
//

import Foundation

public protocol SearchPresentationLogic {
    var view: SearchDisplayLogic? { get }
    
    func search(FailedWith error: SearchEnumError)
    func searchDidBrougntResults(in arrResults: [ImageTextTableViewProtocol])
}

public class SearchPresenter {
    public weak var view: SearchDisplayLogic?
    
    public init(view: SearchDisplayLogic? = nil) {
        self.view = view
    }
}

extension SearchPresenter: SearchPresentationLogic {
    public func search(FailedWith error: SearchEnumError) {
        view?.placeInLabel(message: error.getString())
        
    }
    
    public func searchDidBrougntResults(in arrResults: [ImageTextTableViewProtocol]) {
        view?.placeInLabel(message: "")
        
        view?.showResults(in: arrResults.isEmpty ? [EmptySearch()] : arrResults)
        
    }
}
