//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController {

    var trendingModel: TrendingListProtocol = TrendingViewModel() // protocolo para para poder realizar Testing
    @IBOutlet weak var FilterButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        keychain()
    }
    /// se guarda la respuesta del servicio en el arreglo y se recarga la tabla con la categoria por default
    func getMovieArray() {
        trendingModel.getmovies(category: .Trending)
    }
    
    ///Funcion que guarda y lee de keyChain
    func keychain(){
        let apikey = "asldfjasñldkjfñasdljf"
        let data = Data(apikey.utf8)
        let account = "themoviedb.org"
        let service = "apikey"
        KeychainHelper.standard.genericSave(data, service: service, account: account)
        let result = KeychainHelper.standard.genericRead(service: service, account: account, type: String.self)
    }
    
    ///Configuracion para cuando se cargue la vista
    func setView() {
        self.tabBarController?.viewControllers?[1].title = StringsTitles.search.rawValue
        self.tabBarController?.viewControllers?[2].title = StringsTitles.favorites.rawValue
        trendingModel.bindMovies { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        getMovieArray()
    }
    //MARK: - Buttons
    @IBAction func FilterButton(_ sender: UIBarButtonItem) {
        // Alerta para poder realizar la busqueda por categoria
        let alert = UIAlertController(title: "Filtro", message: "Selecciona el filtro que quieres aplicar", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: categoriesFilter.Trending.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = categoriesFilter.Trending.rawValue
            self?.trendingModel.getmovies(category: .Trending)
        })
        alert.addAction(UIAlertAction(title: categoriesFilter.NowPlaying.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = categoriesFilter.NowPlaying.rawValue
            self?.trendingModel.getmovies(category: .NowPlaying)
        })
        alert.addAction(UIAlertAction(title: categoriesFilter.Popular.rawValue, style: UIAlertAction.Style.default) {[weak self] _ in
            self?.navigationItem.title = categoriesFilter.Popular.rawValue
            self?.trendingModel.getmovies(category: .Popular)
        })
        alert.addAction(UIAlertAction(title: categoriesFilter.TopRated.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = categoriesFilter.TopRated.rawValue
            self?.trendingModel.getmovies(category: .TopRated)
        })
        alert.addAction(UIAlertAction(title: categoriesFilter.Upcoming.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = categoriesFilter.Upcoming.rawValue
            self?.trendingModel.getmovies(category: .Upcoming)
        })
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trendingModel.getMovieCount()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! customCell
        cell.setInfo(trendingModel, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewmodel = DetailsViewModel(movieDetail: trendingModel.getAllInfoMoview(index: indexPath.row))
        let vc = DetailsView(ViewModel: viewmodel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
