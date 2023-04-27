//
//  DetailPresenter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import Foundation

public protocol DetailPresentationLogic {
    var view: DetailSearchDisplayLogic? { get }
    
    func currentInfo(movie: ImageTextTableViewProtocol?)
}

public class DetailPresenter {
    public weak var view: DetailSearchDisplayLogic?
}

extension DetailPresenter: DetailPresentationLogic {
    public func currentInfo(movie: ImageTextTableViewProtocol?) {
        view?.updateTable(withCurrentInfo: movie)
    }
}
