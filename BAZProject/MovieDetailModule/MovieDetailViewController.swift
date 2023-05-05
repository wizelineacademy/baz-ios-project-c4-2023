//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 27/04/23.
//

import UIKit

enum ImageBarButtonItem {
    case heart
    case heartFill
    
    var nameImage: String {
        switch self {
        case .heart:
            return "heart"
        case .heartFill:
            return "heart.fill"
        }
    }
}

class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailPresenterProtocol?
    
    let favoriteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Agregar Favoritos", for: .normal)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUIBarButtonItem()
        isFavorite()
        self.presenter?.notifyViewLoaded()
        // Do any additional setup after loading the view.
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    private func isFavorite() {
        let imageButton: String = IsSaveMovie() ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageButton), for: .normal)
    }
    
    func makeUIBarButtonItem() {
        favoriteButton.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        self.view.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 550)
        ])
    }
    
    @objc func addFavorite() {
        if IsSaveMovie() {
            presenter?.deleteToFavoriteMovie()
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            presenter?.saveFavoriteMovie()
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    private func IsSaveMovie() -> Bool {
        guard let movieId = presenter?.movieId,
              let isSavedMovieId = presenter?.interactor?.saveData.isSave( movieId: movieId) else {
            return false
        }
        return isSavedMovieId
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.lblMovieTitle.text = self.presenter?.movieDetail?.title ?? ""
            self.lblMovieOverview.text = self.presenter?.movieDetail?.overview ?? ""
        }
        if let posterPath = self.presenter?.movieDetail?.posterPath, let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            imageURL.toImage() { image in
                DispatchQueue.main.async {
                    self.MovieImage.image = image
                }
            }
        } else {
        }
    }
    
}
