//
//  MovieFoundInfo.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//

import Foundation

protocol MovieFoundInfo {
    var id: Int { get }
    var title: String { get }
    var posterPath: String? { get }
}
