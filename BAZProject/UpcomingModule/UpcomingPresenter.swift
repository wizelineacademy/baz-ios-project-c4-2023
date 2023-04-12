//
//  UpcomingPresenter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class UpcomingPresenter  {
    
    // MARK: Properties
    weak var view: UpcomingViewProtocol?
    var interactor: UpcomingInteractorInputProtocol?
    var wireFrame: UpcomingWireFrameProtocol?
    
}

extension UpcomingPresenter: UpcomingPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension UpcomingPresenter: UpcomingInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
