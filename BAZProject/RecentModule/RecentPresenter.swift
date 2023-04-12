//
//  RecentPresenter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class RecentPresenter  {
    
    // MARK: Properties
    weak var view: RecentViewProtocol?
    var interactor: RecentInteractorInputProtocol?
    var wireFrame: RecentWireFrameProtocol?
    
}

extension RecentPresenter: RecentPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension RecentPresenter: RecentInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
