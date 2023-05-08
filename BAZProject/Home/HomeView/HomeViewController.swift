//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 28/03/23.
//

// TODO: Usar core data(1) o file manager para la persistencia de datos más pesados, los del detalle de películas
// TODO: AVFUndation tomar el proyecto para el audio
// TODO: Para el Core Location, si estamos en mexico mostrar los resultados mx y en español, si no en inglés, poner un booleano para ahorrar tiempo y problemas
// TODO: Definir unas coordenadas aleatorias al momento de instanciar una película y asignarlas para depués poder mostrar el mapa con MapKit
// TODO: Detalle de película y busqueda por id y palabra clave.

import UIKit

class HomeViewController: UIViewController, AlertPresentable {
    
    // MARK: Variables
    var presenter: ViewToPresenterProtocol?
    
    // MARK: UIElements
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
        presenter?.getMoviesData()
        
    }
    
    // MARK: Initial configurations
    private func initialConfiguration(){
        registerCollections(nibName: "MovieAppCollectionViewCell", identifier: "HomeViewCellId")
        assignDataSource()
        assignDelegates()
    }
    
    private func registerCollections(nibName: String, identifier: String) {
        trendingCollectionView.register(UINib(nibName: nibName, bundle: .main), forCellWithReuseIdentifier: identifier)
        nowPlayingCollectionView.register(UINib(nibName: nibName, bundle: .main), forCellWithReuseIdentifier: identifier)
        popularCollectionView.register(UINib(nibName: nibName, bundle: .main), forCellWithReuseIdentifier: identifier)
        topRatedCollectionView.register(UINib(nibName: nibName, bundle: .main), forCellWithReuseIdentifier: identifier)
        upcomingCollectionView.register(UINib(nibName: nibName, bundle: .main), forCellWithReuseIdentifier: identifier)
    }
    private func assignDataSource(){
        trendingCollectionView.dataSource = self
        nowPlayingCollectionView.dataSource = self
        popularCollectionView.dataSource = self
        topRatedCollectionView.dataSource = self
        upcomingCollectionView.dataSource = self
    }
    
    private func assignDelegates(){
        trendingCollectionView.delegate = self
        nowPlayingCollectionView.delegate = self
        popularCollectionView.delegate = self
        topRatedCollectionView.delegate = self
        upcomingCollectionView.delegate = self
    }
}

// MARK: Data source extension
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trendingCollectionView {
            guard let numberOfItems = presenter?.getNumberOfItems(presenter?.trendingMovies ?? []) else { return 0 }
            return numberOfItems
        } else if collectionView == nowPlayingCollectionView {
            guard let numberOfItems = presenter?.getNumberOfItems(presenter?.nowPlayingMovies ?? []) else { return 0 }
            return numberOfItems
        } else if collectionView == popularCollectionView {
            guard let numberOfItems = presenter?.getNumberOfItems(presenter?.popularMovies ?? []) else { return 0 }
            return numberOfItems
        } else if collectionView == topRatedCollectionView {
            guard let numberOfItems = presenter?.getNumberOfItems(presenter?.topRatedMovies ?? []) else { return 0 }
            return numberOfItems
        } else if collectionView == upcomingCollectionView {
            guard let numberOfItems = presenter?.getNumberOfItems(presenter?.upcomingMovies ?? []) else { return 0 }
            return numberOfItems
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCellId", for: indexPath) as? MovieAppCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView == trendingCollectionView {
            if let movieDate = presenter?.getCellText(presenter?.trendingMovies ?? [], index: indexPath) {
                cell.cellLabel.text = "\(movieDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getCellImage(presenter?.trendingMovies ?? [], index: indexPath)
            // TODO: (SDA) Erase the next line
//            showAlert("Done", "You have shown an alert")
        } else if collectionView == nowPlayingCollectionView {
            if let movieDate = presenter?.getCellText(presenter?.nowPlayingMovies ?? [], index: indexPath) {
                cell.cellLabel.text = "\(movieDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getCellImage(presenter?.nowPlayingMovies ?? [], index: indexPath)
        } else if collectionView == popularCollectionView {
            if let movieDate = presenter?.getCellText(presenter?.popularMovies ?? [], index: indexPath) {
                cell.cellLabel.text = "\(movieDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getCellImage(presenter?.popularMovies ?? [], index: indexPath)
        } else if collectionView == topRatedCollectionView {
            if let movieDate = presenter?.getCellText(presenter?.topRatedMovies ?? [], index: indexPath) {
                cell.cellLabel.text = "\(movieDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getCellImage(presenter?.topRatedMovies ?? [], index: indexPath)
        } else if collectionView == upcomingCollectionView {
            if let movieDate = presenter?.getCellText(presenter?.upcomingMovies ?? [], index: indexPath) {
                cell.cellLabel.text = "\(movieDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getCellImage(presenter?.upcomingMovies ?? [], index: indexPath)
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Home movie selection.")
        var model:Viewable
        switch collectionView {
        case trendingCollectionView:
            model = (presenter?.trendingMovies[indexPath.row])!
            print("Trending movie.")
            presenter?.prepareDetail(movie: model as! Movie)
        case nowPlayingCollectionView:
            model = (presenter?.nowPlayingMovies[indexPath.row])!
            print("Now playing movie.")
            presenter?.prepareDetail(movie: model as! Movie)
        case popularCollectionView:
            model = (presenter?.popularMovies[indexPath.row])!
            print("Popular movie.")
            presenter?.prepareDetail(movie: model as! Movie)
        case topRatedCollectionView:
            model = (presenter?.topRatedMovies[indexPath.row])!
            print("Top rated movie.")
            presenter?.prepareDetail(movie: model as! Movie)
        case upcomingCollectionView:
            model = (presenter?.upcomingMovies[indexPath.row])!
            print("Upcoming movie.")
            presenter?.prepareDetail(movie: model as! Movie)
        default:
            return
        }
    }
}

// MARK: Comformance PresenterToViewProtocol
extension HomeViewController: PresenterToViewProtocol {
    func reloadView() {
        DispatchQueue.main.async { [weak self] in
            self?.trendingCollectionView.reloadData()
            self?.nowPlayingCollectionView.reloadData()
            self?.popularCollectionView.reloadData()
            self?.topRatedCollectionView.reloadData()
            self?.upcomingCollectionView.reloadData()
        }
    }
    
    func showAlertFromPresenter(title: String, message: String) {
        showAlert(title, message)
    }
}

extension HomeViewController: RouterToViewHomeProtocol {
    func presentDetail(vc: UIViewController) {
        present(vc, animated: true)
    }
    
}
