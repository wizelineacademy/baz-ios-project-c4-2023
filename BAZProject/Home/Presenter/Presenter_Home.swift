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
    var router: PresenterToRouterHomeProtocol?
    var imageCache: NSCache = NSCache< NSString, UIImage>()
    
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
    
    func getNumberOfItems(_ items: [Viewable]) -> Int {
        return items.count
    }
    
    func getCellText(_ items: [Viewable], index: IndexPath) -> String {
        guard let optionalInfo = items[index.row].getAdditionalInfo() else { return "" }
        return optionalInfo
    }
    
    func getCellImage(_ items: [Viewable], index: IndexPath) -> UIImage {
        var returnedImage = UIImage()
        var basePath = "https://image.tmdb.org/t/p/w500"
        //TODO: Change the next line to show a defaul image when imagePath is nil
        guard let image = items[index.row].getImagePath() else {return UIImage()}
        basePath.append(image)
        
        guard let url = URL(string: basePath) else { return UIImage() }
        if let cacheImage = loadFromCache(imageAt: url) {
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
        print("LOADING AN IMAGE!!!!!")
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
    
    func prepareDetail(movie: Movie) {
        print("Presenter recieved object from HomeView")
        router?.showDetail(item: movie)
    }
    
    // MARK: InteractorToPresenter protocol conformance
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            self.view?.showAlertFromPresenter(title: title, message: message)
        }
    }
}
