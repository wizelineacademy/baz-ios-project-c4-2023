//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController {

    var trendingModel: TrendingListProtocol = TrendingViewModel() // protocolo para para poder realizar Testing
    
    // MARK: -Oulets
    
    @IBOutlet weak var FilterButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        keychain()
    }
    
    /// se guarda la respuesta del servicio en el arreglo y se recarga la tabla con la categoria por default
    func getMovieArray() {
        trendingModel.getmovies(category: .trending)
    }
    
    ///Funcion que guarda y lee de keyChain
    func keychain() {
        let apikey = "asldfjasñldkjfñasdljf"
        let data = Data(apikey.utf8)
        let account = "themoviedb.org"
        let service = "apikey"
        KeychainHelper.standard.genericSave(data, service: service, account: account)
        let result = KeychainHelper.standard.genericRead(service: service, account: account, type: String.self)
    }
    
    ///Configuracion para cuando se cargue la vista
    func setView() {
        self.tabBarController?.viewControllers?[1].title = Titles.search
        self.tabBarController?.viewControllers?[2].title = Titles.favorites
        self.tabBarController?.tabBar.items![1].image = Icon.magnify
        self.tabBarController?.tabBar.items![1].selectedImage = Icon.magnifyFill
        self.tabBarController?.tabBar.items![2].image = Icon.heart
        self.tabBarController?.tabBar.items![2].selectedImage = Icon.heartFill
        
        trendingModel.bindMovies { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        getMovieArray()
        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "TrendingTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Buttons
    
    ///Alerta para el filtrado de peliculas
    @IBAction func FilterButton(_ sender: UIBarButtonItem) {
        // Alerta para poder realizar la busqueda por categoria
        let alert = UIAlertController(title: "Filtro", message: "Selecciona el filtro que quieres aplicar", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: CategoriesFilter.trending.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = CategoriesFilter.trending.rawValue
            self?.trendingModel.getmovies(category: .trending)
        })
        alert.addAction(UIAlertAction(title: CategoriesFilter.nowPlaying.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = CategoriesFilter.nowPlaying.rawValue
            self?.trendingModel.getmovies(category: .nowPlaying)
        })
        alert.addAction(UIAlertAction(title: CategoriesFilter.popular.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = CategoriesFilter.popular.rawValue
            self?.trendingModel.getmovies(category: .popular)
        })
        alert.addAction(UIAlertAction(title: CategoriesFilter.topRated.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = CategoriesFilter.topRated.rawValue
            self?.trendingModel.getmovies(category: .topRated)
        })
        alert.addAction(UIAlertAction(title: CategoriesFilter.upcoming.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = CategoriesFilter.upcoming.rawValue
            self?.trendingModel.getmovies(category: .upcoming)
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
        Constant.favoritesCellHeight
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrendingTableViewCell
        cell.setInfo(trendingModel, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewmodel = DetailsViewModel(movieDetail: trendingModel.getAllInfoMoview(index: indexPath.row))
        let vc = DetailsViewController(viewModel: viewmodel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
