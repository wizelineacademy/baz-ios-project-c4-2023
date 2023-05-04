//
//  Presenter_Home.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation
import UIKit

class Presenter: ViewToPresenterProtocol, InteractorToPresenter {
    
    // MARK: Variables
    var interactor: PresenterToInteractor?
    var view: PresenterToViewProtocol?
    var imageCache: NSCache = NSCache<NSString, UIImage>()
    
    var trendingMovies: [Viewable] = [] {
        didSet {
            view?.reloadView()
        }
    }
    var nowPlayingMovies: [Viewable] = [] {
        didSet {
            view?.reloadView()
        }
    }
    var popularMovies: [Viewable] = [] {
        didSet {
            view?.reloadView()
        }
    }
    var topRatedMovies: [Viewable] = [] {
        didSet {
            view?.reloadView()
        }
    }
    var upcomingMovies: [Viewable] = [] {
        didSet {
            view?.reloadView()
        }
    }

    // MARK: Comformance ViewToPresenterProtocol
    func getMoviesData() {
        interactor?.getMoviesData()
    }
    
    func getNumberOfTrendingItems() -> Int {
        return trendingMovies.count
    }
    func getNumberOfNowPlayingItems() -> Int {
        return nowPlayingMovies.count
    }
    func getNumberOfPopularItems() -> Int {
        return popularMovies.count
    }
    func getNumberOfTopRatedItems() -> Int {
        return topRatedMovies.count
    }
    func getNumberOfUpcomingItems() -> Int {
        return upcomingMovies.count
    }
    
    func getTrendingCellText(index: IndexPath) -> String {
        return trendingMovies[index.row].getReleaseData()
    }
    func getNowPlayingCellText(index: IndexPath) -> String {
        return nowPlayingMovies[index.row].getReleaseData()
    }
    func getPopularCellText(index: IndexPath) -> String {
        return popularMovies[index.row].getReleaseData()
    }
    func getTopRatedCellText(index: IndexPath) -> String {
        return topRatedMovies[index.row].getReleaseData()
    }
    func getUpcomingCellText(index: IndexPath) -> String {
        return upcomingMovies[index.row].getReleaseData()
    }
    
    func getTrendingCellImage(index: IndexPath) -> UIImage {
        var returnedImage = UIImage()
        var basePath = "https://image.tmdb.org/t/p/w500"
        basePath.append(trendingMovies[index.row].getImagePath())
        guard let url = URL(string: basePath) else { return UIImage() }
        if let cacheImage = loadFromCache(imageAt: url ) {
            return cacheImage
        } else {
            loadImage(url){ image in
                returnedImage = image!
            }
            view?.reloadView()
            return returnedImage
        }
    }
    func getNowPlayingCellImage(index: IndexPath) -> UIImage {
        var returnedImage = UIImage()
        var basePath = "https://image.tmdb.org/t/p/w500"
        basePath.append(nowPlayingMovies[index.row].getImagePath())
        guard let url = URL(string: basePath) else { return UIImage() }
        if let cacheImage = loadFromCache(imageAt: url ) {
            return cacheImage
        } else {
            loadImage(url){ image in
                returnedImage = image!
            }
            view?.reloadView()
            return returnedImage
        }
    }
    func getPopularCellImage(index: IndexPath) -> UIImage {
        var returnedImage = UIImage()
        var basePath = "https://image.tmdb.org/t/p/w500"
        basePath.append(popularMovies[index.row].getImagePath())
        guard let url = URL(string: basePath) else { return UIImage() }
        if let cacheImage = loadFromCache(imageAt: url ) {
            return cacheImage
        } else {
            loadImage(url){ image in
                returnedImage = image!
            }
            view?.reloadView()
            return returnedImage
        }
    }
    func getTopRatedCellImage(index: IndexPath) -> UIImage {
        var returnedImage = UIImage()
        var basePath = "https://image.tmdb.org/t/p/w500"
        basePath.append(topRatedMovies[index.row].getImagePath())
        guard let url = URL(string: basePath) else { return UIImage() }
        if let cacheImage = loadFromCache(imageAt: url ) {
            return cacheImage
        } else {
            loadImage(url){ image in
                returnedImage = image!
            }
            view?.reloadView()
            return returnedImage
        }
    }
    func getUpcomingCellImage(index: IndexPath) -> UIImage {
        var returnedImage = UIImage()
        var basePath = "https://image.tmdb.org/t/p/w500"
        basePath.append(upcomingMovies[index.row].getImagePath())
        guard let url = URL(string: basePath) else { return UIImage() }
        if let cacheImage = loadFromCache(imageAt: url ) {
            return cacheImage
        } else {
            loadImage(url){ image in
                returnedImage = image!
            }
            view?.reloadView()
            return returnedImage
        }
    }
    
    func loadFromCache(imageAt url: URL) -> UIImage? {
        let imageKey = url.absoluteString as NSString
        return imageCache.object(forKey: imageKey)
    }
    
    func loadImage(_ url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
