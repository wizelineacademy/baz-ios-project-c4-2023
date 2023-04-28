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
    func serviceDidFailed(with error: ErrorApi)
    func similarMoviewsObtained(with result: [ImageTextTableViewProtocol]?)
}

public class DetailPresenter {
    public weak var view: DetailSearchDisplayLogic?
    
    public init() {}
}

extension DetailPresenter: DetailPresentationLogic {
    public func currentInfo(movie: ImageTextTableViewProtocol?) {
        view?.updateTable(withCurrentInfo: movie)
    }
    
    public func serviceDidFailed(with error: ErrorApi) {
        view?.serviceDidFailed(with: error.getMessage())
    }
    
    public func similarMoviewsObtained(with result: [ImageTextTableViewProtocol]?) {
        guard let result = result else { return }
        var arrToView: [ImageTextTableViewProtocol] = [ImageTextTableViewProtocol]()
        
        switch result.count {
        case 0:
            arrToView = [EmptySearch()]
        default:
            arrToView = Array(result.prefix(2))
        }
        
        view?.reloadSimilarMovies(with: arrToView)
    }
}
