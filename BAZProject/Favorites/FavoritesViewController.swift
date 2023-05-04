//
//  FavoritesViewController.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var ViewModel: FavoritesViewModel = FavoritesViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = StringsTitles.favorites.rawValue
        ViewModel.getFavoritesMovies(key: UserDKeys.favorites.rawValue)
        ViewModel.bindMovie { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    ///Funcion que setea la vista
    func setView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCells()
    }
    
    ///Se registran las celdas para las peliculas
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "Cell")
    }
    //Boton para refrescar la lista 
    @IBAction func reloadButton(_ sender: Any) {
        tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ViewModel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
        cell.setInfo(ViewModel, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewmodel = DetailsViewModel(movieDetail: ViewModel.getAllInfoMoview(index: indexPath.row))
        let vc = DetailsView(ViewModel: viewmodel)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
}
