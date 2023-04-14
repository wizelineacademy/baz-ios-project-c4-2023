//
//  MovieProtocol.swift
//  BAZProject
//
//  Created by ksolano on 03/04/23.
//

import Foundation

// This protocol gives the properties that we want a movie to have.
protocol MovieProtocol {
    var id: Int { get }
    var title: String { get }
    var poster_path: String { get }
}
