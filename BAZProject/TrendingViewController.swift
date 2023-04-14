//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController, Storyboard {

    var movies              : [MovieData] = []
    var movieApi            : MovieAPI? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callServiceMovieAPI()
    }
    
    /**
     This function returns a success or error.
     
    - Returns:
       - success: return The type of the value to decode from the supplied JSON object.
       - error: returns the service error.
    */
    private func callServiceMovieAPI(){
        movieApi?.getMovies(.getMovieDay){ [weak self] (result: Result< MoviesResult, Error>) in
            switch result {
            case .success(let moviesReponse):
                if let arrMovies = moviesReponse.arrMovies{
                    for resultArrMovies in arrMovies{
                        self?.movies.append(MoviesViewModels(title: resultArrMovies.title ?? "",
                                                                    poster_path: resultArrMovies.posterPath ?? ""))
                    }
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            default:
                self?.present(CWAlert.simpleWith(message: "Error al realizar"), animated: true)
            }
        }
    }

}

// MARK: - TableView's DataSource
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate
extension TrendingViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        let infoMovieCell = movies[indexPath.row]
        config.text = infoMovieCell.title
        infoMovieCell.getImage(){ imagen in
            config.image = imagen
            cell.contentConfiguration = config
        }
        cell.contentConfiguration = config
    }
}
