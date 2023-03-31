//
//  TrendingBarInteractorInputProtocolExtension.swift
//  BAZProject
//
//  Created by 989438 on 31/03/23.
//

import Foundation

extension TrendingBarInteractorInputProtocol {
    func linkDependencies(remoteData: TrendingBarRemoteDataInputProtocol, presenter: TrendingBarInteractorOutputProtocol) {
        self.presenter = presenter
        self.remoteData = remoteData
    }
}
