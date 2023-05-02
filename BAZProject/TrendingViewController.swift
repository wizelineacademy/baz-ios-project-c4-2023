//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit
import Foundation

final class TrendingViewController: UIViewController, Storyboard {
    
    @IBOutlet weak var btnOptionsFilterMovies: UIBarButtonItem!
    @IBOutlet weak var tblMovies: UITableView!{
        didSet{
            registerNibs(in: tblMovies)
            style(to: tblMovies)
            tblMovies.delegate      = self
            tblMovies.dataSource    = self
        }
    }
    var movies              : [MovieData] = []
    var movieApi            : MovieAPI? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        callServiceMovieAPI(request: OptionMovie.getMovieDay.request)
    }
    
    /// Configuration is set to the table
    private func style(to tableView: UITableView){
        tableView.bounces                        = false
        tableView.separatorStyle                 = .none
        tableView.backgroundColor                = .white
        tableView.allowsSelection                = true
        tableView.alwaysBounceVertical           = false
        tableView.alwaysBounceHorizontal         = false
        tableView.allowsMultipleSelection        = false
        tableView.showsVerticalScrollIndicator   = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.estimatedRowHeight             = UITableView.automaticDimension
    }
    
    //Registers a nib object that contains a cell with specified identifier.
    private func registerNibs(in tableView: UITableView) {
        tableView.register(UINib(nibName: CellMovies.identifier, bundle: nil),
                           forCellReuseIdentifier: CellMovies.identifier)
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
                        self?.tblMovies.reloadData()
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

// MARK: - TableView's DataSource - Delegate
extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CellMovies", for: indexPath) as? CellMovies else {
            return UITableViewCell()
        }
        let infoCell        = movies[indexPath.row]
        cell.descriptionMovie.text  = infoCell.title
        if let posterPath = infoCell.poster_path{
            cell.imgMovie.download(poster_path: posterPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MoviesDetailRouter.createModule(with: movies[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    
}
