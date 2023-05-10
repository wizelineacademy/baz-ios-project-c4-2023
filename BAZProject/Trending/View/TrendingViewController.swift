//
//  TrendingViewController.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//

import UIKit

class TrendingViewController: UITableViewController {
    
    @IBOutlet weak var sgmListMovie: UISegmentedControl!
    var presenter: TrendingPresenterProtocol?
    var entity: TrendingEntity?
    var data: [Movie] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshDetail()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
    }
    
    func refreshDetail(){
        Loader.start()
        presenter?.willFetchMovies()
    }

    @IBAction func sgmSelection(_ sender: Any) {
        let selection = TypeList(rawValue: sgmListMovie.selectedSegmentIndex)
        guard let entity = self.entity else { return }
        switch selection{
        case .trending:
            data = entity.movieDetailData.trendingMovies.items
            self.tableView.reloadData()
        case .nowPlaying:
            data = entity.movieDetailData.nowPlayingMovies.items
            self.tableView.reloadData()
        case .popular:
            data = entity.movieDetailData.popular.items
            self.tableView.reloadData()
        case .topRated:
            data = entity.movieDetailData.topRated.items
            self.tableView.reloadData()
        case .upcoming:
            data = entity.movieDetailData.upcoming.items
            self.tableView.reloadData()
        default:
            break
        }
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GeneralTableViewCell.identifier, for: indexPath) as? GeneralTableViewCell{
            let movie = data[indexPath.row]
            cell.setup(movie)
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = data[indexPath.row]
        let detailMovieEntity = DetailMovieEntity(baseInfo: movie)
        let detail = DetailMovieRouter.createDetailMovieModule(withEntity: detailMovieEntity)
        self.navigationController?.pushViewController(detail, animated: true)
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController: TrendingViewProtocol {
    // TODO: implement view output methods
    func setNavigationTitle(for strTitle: String?){
        navigationItem.title = strTitle
    }
    
    func updateData(_ entity: TrendingEntity) {
        self.entity? = entity
        self.data = entity.movieDetailData.trendingMovies.items
    }
    
    func updataView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            Loader.stop()
        }
    }
    
    func registrerCell(){
        tableView.register(UINib(nibName: GeneralTableViewCell.identifier, bundle : nil), forCellReuseIdentifier: GeneralTableViewCell.identifier)
    }
    
}

enum TypeList: Int {
    case trending = 0
    case nowPlaying = 1
    case popular = 2
    case topRated = 3
    case upcoming = 4
}
