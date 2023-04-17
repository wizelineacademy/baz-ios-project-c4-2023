//
//  SearchRouter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 16/04/23.
//

import Foundation
import UIKit

class SearchRouter {
    
    static func createModule() -> UIViewController {
        let view = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
