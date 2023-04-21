//  SearchProtocols.swift
//  BAZProject
//
//  Created by jehernandezg on 20/04/23.

import UIKit

// MARK: - View (Presenter To View)
protocol SearchViewInputProtocol: AnyObject {
    var presenter: SearchViewOutputProtocol? { get }
}

// MARK: - Presenter

// MARK: - (View To Presenter)
protocol SearchViewOutputProtocol {
	var view: SearchViewInputProtocol? { get }
	var interactor: SearchInteractorInputProtocol { get }
	var router: SearchRouterProtocol { get }
}

// MARK: - (Interactor To Presenter)
protocol SearchInteractorOutputProtocol: AnyObject {
    
}

// MARK: - Interactor (Presenter To Interactor)
protocol SearchInteractorInputProtocol {
    var presenter: SearchInteractorOutputProtocol? { get }
}

// MARK: - Router (Presenter To Router)
protocol SearchRouterProtocol {
    var view: UIViewController? { get }
}
