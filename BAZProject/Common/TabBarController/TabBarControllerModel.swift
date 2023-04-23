//
//  TabBarControllerModel.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 22/04/23.
//

import Foundation
import UIKit
///Protocolo que implementa la estructuira que debe tener el un tabBarItem
protocol TabElementsProtocol{
    ///propiedad que regresa un UIVIewController del elemento
    var controller: UIViewController { get }
    ///propiedad que regresa un String con la descripcion del titulo del elemento
    var title: String { get }
    ///propiedad que regresa un UIImage con la representacion del Icono del elemento
    var image: UIImage? { get }
}

///Estructura de un tabBarItem
enum TabViewControllers: TabElementsProtocol{
    case trendeing
}

extension TabViewControllers{
    var controller: UIViewController{
        switch self {
        case .trendeing:
            return TrendingMoviesRouter.createModule()
        }
    }
    
    var title: String{
        switch self {
        case .trendeing:
            return "Trending"
        }
    }
    
    var image: UIImage?{
        switch self {
        case .trendeing:
            return UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
        }
    }
}
