//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController, Storyboard {

    @IBOutlet weak var btnOptionsFilterMovies: UIBarButtonItem!
    var movies              : [MovieData] = []
    var movieApi            : MovieAPI? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        callServiceMovieAPI(optionFilter: .getMovieDay)
    }
    
    /**
     This function returns a success or error.
     
    - Returns:
       - success: return The type of the value to decode from the supplied JSON object.
       - error: returns the service error.
    */
    private func callServiceMovieAPI(optionFilter : OptionMovie){
        movieApi?.getMovies(optionFilter){ [weak self] (result: Result< MoviesResult, Error>) in
            switch result {
            case .success(let moviesReponse):
                self?.movies.removeAll()
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
    
    private func setNavTitle(with title: String){
        self.title = title
    }

    // btnAction - send you the next 'search view'
    @IBAction func searchMovie(_ sender: Any) {
        let viewController = MoviesRouter.createModule()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // btnAction - options with the different search filters
    func setup(){
        var optionsItems: [UIAction]{
            return [ UIAction(title: "Treanding", handler: { [weak self] _ in
                self?.callServiceMovieAPI(optionFilter: .getMovieDay)
                self?.setNavTitle(with: "Treanding")
            }),
                     UIAction(title: "Now Playing", handler: { [weak self] _ in
                self?.callServiceMovieAPI(optionFilter: .getNowPlaying)
                self?.setNavTitle(with: "Now Playing")
            }),
                     UIAction(title: "Popular", handler: { [weak self] _ in
                self?.callServiceMovieAPI(optionFilter: .getPopular)
                self?.setNavTitle(with: "Popular")
            }),
                     UIAction(title: "Top Rated", handler: { [weak self] _ in
                self?.callServiceMovieAPI(optionFilter: .getTopRated)
                self?.setNavTitle(with: "Top Rated")
            }),
                     UIAction(title: "Upcoming", handler: { [weak self] _ in
                self?.callServiceMovieAPI(optionFilter: .getUpcoming)
                self?.setNavTitle(with: "Upcoming")
            })]
        }
        btnOptionsFilterMovies.menu = UIMenu(title: "Selecciona una opción", children: optionsItems)
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

enum OptionsFilterMovies {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
}
