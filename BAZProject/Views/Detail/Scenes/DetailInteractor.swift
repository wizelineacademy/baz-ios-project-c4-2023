//
//  DetailInteractor.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import Foundation

public protocol DetailBusinessLogic {
    var presenter: DetailPresentationLogic? { get }
    
    func getCurrentData()
}

public class DetailInteractor {
    public var presenter: DetailPresentationLogic?
    public var entity: DetailInfo?
    
    public init(presenter: DetailPresentationLogic? = nil, entity: DetailInfo? = nil) {
        self.presenter = presenter
        self.entity = entity
    }
    
    public func setUpEntity(withMovie movie: Movie) {
        entity = nil
        entity = DetailInfo(movie: movie)
    }
}

extension DetailInteractor: DetailBusinessLogic {
    public func getCurrentData() {
        presenter?.currentInfo(movie: entity?.movie)
    }
}
