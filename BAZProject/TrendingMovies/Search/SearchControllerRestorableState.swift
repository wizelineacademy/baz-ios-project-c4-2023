//
//  TrendingMoviesViewController+Restore.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 21/04/23.
//

import Foundation

///Protocolo que contiene los estados a restablecer del  UIViewcontroller que implementa la busqueda
protocol RestorableStateProtocol{
    var wasActive: Bool {get set}
    var wasFirstResponder: Bool {get set}
}

struct SearchControllerRestorableState: RestorableStateProtocol {
    var wasActive = false
    var wasFirstResponder = false
}
