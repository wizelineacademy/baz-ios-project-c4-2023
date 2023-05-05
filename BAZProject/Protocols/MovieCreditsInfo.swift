//
//  MovieCreditsInfo.swift
//  BAZProject
//
//  Created by Carlos Garcia on 28/04/23.
//

import Foundation

protocol MovieCreditsInfo {
    var id: Int { get }
    var cast: [MovieCastInfo] { get }
}
