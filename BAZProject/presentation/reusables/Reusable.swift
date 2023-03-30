//
//  Reusable.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import Foundation

protocol CellReusable {
    var identifierCellReusable: String { get }
}

extension CellReusable {
    var identifierCellReusable: String { String(describing: self)}
}
