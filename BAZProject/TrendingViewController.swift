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
        callServiceMovieAPI(request: OptionMovie.getMovieDay.request)
    }
    
    /**
     This function returns a success or error.
     
    - Returns:
       - success: return The type of the value to decode from the supplied JSON object.
       - error: returns the service error.
    */
    private func callServiceMovieAPI(request : URLRequest){
        movieApi?.getMovies(request){ [weak self] (result: Result< MoviesResult, Error>) in
            switch result {
            case .success(let moviesReponse):
                self?.movies.removeAll()
                if let arrMovies = moviesReponse.movies{
                    for resultArrMovies in arrMovies{
                        self?.movies.append(MoviesViewModels(title: resultArrMovies.title ?? "",
                                                             poster_path: resultArrMovies.posterPath ?? "",
                                                             original_title: resultArrMovies.originalTitle ?? "",
                                                             id: resultArrMovies.id ?? 0,
                                                             overview: resultArrMovies.overview ?? ""))
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
        let viewController = SearchMoviesRouter.createModule()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // btnAction - options with the different search filters
    private func setup(){
        let categories: [(String, OptionMovie)] = [
            ("Trending",.getMovieDay),
            ("Now Playing",.getNowPlaying),
            ("Popular",.getPopular),
            ("Top Rated", .getTopRated),
            ("Upcoming", .getUpcoming)]
        let optionsItems: [UIAction] = categories.map {
            self.createUIAction(with: $0.0, option: $0.1)
        }
        btnOptionsFilterMovies.menu = UIMenu(title: "Selecciona una opción", children: optionsItems)
    }
    
    private func createUIAction(with title: String, option: OptionMovie) -> UIAction{
        return UIAction(title: title, handler: { [weak self] _ in
            self?.callServiceMovieAPI(request: option.request)
            self?.setNavTitle(with: title)
        })
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MoviesDetailRouter.createModule(with: movies[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - TableView's Delegate
extension TrendingViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        let infoMovieCell = movies[indexPath.row]
        config.text = infoMovieCell.title
        /*infoMovieCell.getImage(){ imagen in
            config.image = imagen
            cell.contentConfiguration = config
        }*/
        cell.contentConfiguration = config
    }
}
