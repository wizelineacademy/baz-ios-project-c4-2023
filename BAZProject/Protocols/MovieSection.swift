//
//  MovieSection.swift
//  BAZProject
//
//  Created by Carlos Garcia on 19/04/23.
//

import Foundation
import UIKit

protocol MovieSection {
    var strTitle: String { get }
    var movies: [MovieInfo] { get set }
}
