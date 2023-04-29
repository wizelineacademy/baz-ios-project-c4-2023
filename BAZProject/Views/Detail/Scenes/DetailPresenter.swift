//
//  DetailPresenter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import Foundation

public protocol DetailPresentationLogic {
    var view: DetailSearchDisplayLogic? { get }
    
    func currentInfo(movie: CellPersonalizedTableViewProtocol?)
    func serviceDidFailed(with error: ErrorApi)
    func similarMoviewsObtained(with result: [CellPersonalizedTableViewProtocol]?)
    func reviewsWereObtained(with arrReviews: [CellPersonalizedTableViewProtocol]?)
}

public class DetailPresenter {
    public weak var view: DetailSearchDisplayLogic?
    
    public init() {}
}

extension DetailPresenter: DetailPresentationLogic {
    public func currentInfo(movie: CellPersonalizedTableViewProtocol?) {
        view?.updateTable(withCurrentInfo: movie)
    }
    
    public func serviceDidFailed(with error: ErrorApi) {
        view?.serviceDidFailed(with: error.getMessage())
    }
    
    public func similarMoviewsObtained(with result: [CellPersonalizedTableViewProtocol]?) {
        guard let result = result else { return }
        let arrToView = filter(array: result, upTo: 2)
        view?.reloadSimilarMovies(with: arrToView)
    }
    
    public func reviewsWereObtained(with arrReviews: [CellPersonalizedTableViewProtocol]?) {
        guard let arrReviews = arrReviews else { return }
        let arrToView = filter(array: arrReviews, upTo: 5)
        view?.reloadReviews(with: arrToView)
    }
    
    private func filter(array arrToFilter: [CellPersonalizedTableViewProtocol], upTo iLimit: Int) -> [CellPersonalizedTableViewProtocol] {
        var arrToView: [CellPersonalizedTableViewProtocol] = [CellPersonalizedTableViewProtocol]()
        switch arrToFilter.count {
        case 0:
            arrToView = [EmptySearch()]
        default:
            arrToView = Array(arrToFilter.prefix(iLimit))
        }
        return arrToView
    }
}
