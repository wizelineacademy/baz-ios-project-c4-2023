//
//  DetailInteractor.swift
//  BAZProject
//
//  Created by jehernandezg on 03/05/23.
//

import UIKit

// MARK: - Class
class DetailInteractor {
    // MARK: - Properties
    weak var presenter: DetailInteractorOutputProtocol?
}

// MARK: - Extensions

// MARK: - P R E S E N T E R · T O · I N T E R A C T O R
extension DetailInteractor: DetailInteractorInputProtocol {
    // MARK: - Functions
    
    /// Function that returns a `UIImage` of the selected movie
    /// - Parameter detailMovie: The data of the selected movie
    /// - Version: 1.0.0
    func getDetailMovie(detailMoviePI detailMovie: ListMovieProtocol) {
        presenter?.presentDetailMovie(detailMovie: detailMovie)
    }
    
    /// Function that returns a `UIImage` for a specific movie
    /// - Parameters:
    ///   - imagePath: The final part of the URL image path
    ///   - completion: Returns a UIImage
    ///   - Returns: The image from data.
    ///   Version: 1.0.0
    func getOriginalMovieImage(imagePath: String, completion: @escaping (UIImage?) -> Void) {
        if let path = URL(string: "\(MovieAPIConstans.getOriginalUrl(path: imagePath))") ?? URL(string: "") {
            let imageLoader: ImageLoader = ImageLoader()
            imageLoader.loadImage(from: path) { image in
                completion(image)
            }
        }
    }
}

