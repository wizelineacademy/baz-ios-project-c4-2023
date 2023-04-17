//
//  TrendingBarRouter.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import UIKit

final class TrendingBarRouter: TrendingBarRouterProtocol {
    func createTrendingModule() -> UIViewController {
        let view = TrendingViewController()
        let interactor = TrendingBarInteractor()
        let presenter = TrendingBarPresenter()
        let service = TrendingBarDispatchDecorator(decoratee: ServiceAPI(session: URLSession.shared))
        let remoteData = TrendingBarDataManager(service: service)
        
        view.presenter = presenter
        presenter.linkDependencies(view: view, router: self, interactor: interactor)
        interactor.linkDependencies(remoteData: remoteData, presenter: presenter)
        remoteData.interactor = interactor
        return view
    }
    
    func presentNextViewController(from view: TrendingBarViewControllerProtocol?, to nextView: UIViewController) {
        guard let viewController = view as? UIViewController else { return }
        let nextViewController  = nextView
        viewController.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
