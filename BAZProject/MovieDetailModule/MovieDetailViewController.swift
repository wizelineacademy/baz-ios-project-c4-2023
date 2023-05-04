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
    
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFavorite()
        self.presenter?.notifyViewLoaded()
        // Do any additional setup after loading the view.
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    private func isFavorite() {
        if IsSaveMovie() {
            makeUIBarButtonItem(image: .heartFill)

        } else {
            makeUIBarButtonItem(image: .heart)
        }
    }
    
    func makeUIBarButtonItem(image: ImageBarButtonItem) {
        //let rightButton = UIBarButtonItem(image: UIImage(systemName: image.nameImage), style: .plain, target: self, action: #selector(addFavorite))
        //self.navigationItem.rightBarButtonItem  = rightButton
        let bttnfavorites = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        bttnfavorites.setTitleColor(.blue, for: .normal)
        bttnfavorites.setTitle("Agregar Favoritos", for: .normal)
        bttnfavorites.setImage(UIImage(systemName: image.nameImage), for: .normal)
        bttnfavorites.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        self.view.addSubview(bttnfavorites)
        
        bttnfavorites.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bttnfavorites.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bttnfavorites.topAnchor.constraint(equalTo: view.topAnchor, constant: 550)
        ])
        
    }
    
    @objc func addFavorite() {
        if IsSaveMovie() {
            presenter?.deleteToFavoriteMovie()
            makeUIBarButtonItem(image: .heart)
            /*
            let alert=UIAlertController(title: "Guardado", message: "Movie saved", preferredStyle: .alert)
            let okbutton = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okbutton)
            present(alert, animated: true, completion: nil)
            */
        } else {
            presenter?.saveFavoriteMovie()
            makeUIBarButtonItem(image: .heartFill)
        }
    }
    
    private func IsSaveMovie() -> Bool {
        if let idMovie = presenter?.movieId, !(presenter?.interactor?.saveData.isSave(title: .favoriteMovies, idMovie: idMovie) ?? true) {
            return false
        } else {
            return true
        }
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
