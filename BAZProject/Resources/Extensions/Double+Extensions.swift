//
//  Double+Extensions.swift
//  BAZProject
//
//  Created by jmgarciaca on 08/05/23.
//

import Foundation

extension Double {
    var toRatingFormat: String  {
        "\( Int(((self) * 10).rounded()) )% de calificación"
    }
}
