//
//  TabBarControllerModel.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 22/04/23.
//

import Foundation
import UIKit
///Protocolo que implementa la estructuira que debe tener el un tabBarItem
protocol ViewPropertiesProtocol{
    ///propiedad que regresa un String con la descripcion del titulo del elemento
    var title: String { get }
    ///propiedad que regresa un UIImage con la representacion del Icono del elemento
    var image: UIImage? { get }
}

///Estructura de un tabBarItem
enum ViewControllerElements {
    
    case trending
    case nowPlaying
    case popular
    case topRated
    case upComing
   
}

extension ViewControllerElements: ApiPathProtocol{
    var endPoint: String{
        switch self {
        case .trending:
            return "trending/movie/day"
        case .nowPlaying:
            return "movie/now_playing"
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upComing:
            return "movie/upcoming"
        }
    }
    
    var urlRequest: URLRequest?{
        let urlString = self.pathBase + self.endPoint + self.apiKey
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
    
    var imageUrl: URL?{
        let urlString = self.imagePathBase + self.endPoint
        return URL(string: urlString)
    }
}



extension ViewControllerElements: ViewPropertiesProtocol {
    
    var title: String{
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upComing:
            return "Upcoming"
        }
    }
    
    var image: UIImage?{
        switch self {
        case .trending:
            return UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
        case .nowPlaying:
            return UIImage(systemName: "display")
        case .popular:
            return UIImage(systemName: "chart.line.uptrend.xyaxis")
        case .topRated:
            return UIImage(systemName: "star.fill")
        case .upComing:
            return UIImage(systemName: "display.and.arrow.down")
        }
    }
}
