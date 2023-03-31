//
//  TrendingBarPresenterProtocolExtension.swift
//  BAZProject
//
//  Created by 989438 on 31/03/23.
//

import Foundation

extension TrendingBarPresenterProtocol {
    func linkDependencies(view: TrendingBarViewControllerProtocol, router: TrendingBarRouterProtocol, interactor: TrendingBarInteractorInputProtocol) {
        self.view = view
        (self as? TrendingBarInteractorOutputProtocol)?.interactor = interactor
        self.router = router
    }
}
