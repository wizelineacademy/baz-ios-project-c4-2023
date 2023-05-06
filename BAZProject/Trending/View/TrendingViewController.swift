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
        switch selection{
        case .trending:
            print("selected \(sgmListMovie.selectedSegmentIndex)")
        case .nowPlaying:
            print("selected \(sgmListMovie.selectedSegmentIndex)")
        case .popular:
            print("selected \(sgmListMovie.selectedSegmentIndex)")
        case .topRated:
            print("selected \(sgmListMovie.selectedSegmentIndex)")
        case .upcoming:
            print("selected \(sgmListMovie.selectedSegmentIndex)")
        default:
            break
        }
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entity?.result?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GeneralTableViewCell.identifier, for: indexPath) as? GeneralTableViewCell{
            let movie = entity?.result?[indexPath.row]
            cell.setup(movie)
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = entity?.result?[indexPath.row]
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
    
    func updateData(with result: [Movie]) {
        self.entity?.result = result
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
