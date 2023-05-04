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

class HomeViewController: UIViewController {
    
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
        
        // TODO: (SDA) Refactorizar al migrar a Viper
        self.ensambleModule()
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
    
    // MARK: Ensambling provisional "Module"
    private func ensambleModule() {
        let presenterInstance = Presenter()
        let interactorInstance = Interactor()
        
        presenter = presenterInstance
        presenterInstance.interactor = interactorInstance
        interactorInstance.presenter = presenterInstance
        presenterInstance.view = self
    }
}

// MARK: Data source extension
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trendingCollectionView {
            guard let numberOfItems = presenter?.getNumberOfTrendingItems() else { return 0 }
            return numberOfItems
        } else if collectionView == nowPlayingCollectionView {
            guard let numberOfItems = presenter?.getNumberOfNowPlayingItems() else { return 0 }
            return numberOfItems
        } else if collectionView == popularCollectionView {
            guard let numberOfItems = presenter?.getNumberOfPopularItems() else { return 0 }
            return numberOfItems
        } else if collectionView == topRatedCollectionView {
            guard let numberOfItems = presenter?.getNumberOfTopRatedItems() else { return 0 }
            return numberOfItems
        } else if collectionView == upcomingCollectionView {
            guard let numberOfItems = presenter?.getNumberOfUpcomingItems() else { return 0 }
            return numberOfItems
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCellId", for: indexPath) as? MovieAppCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView == trendingCollectionView {
            if let releaseDate = presenter?.getTrendingCellText(index: indexPath) {
                cell.cellLabel.text = "\(releaseDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getTrendingCellImage(index: indexPath)
        } else if collectionView == nowPlayingCollectionView {
            if let releaseDate = presenter?.getNowPlayingCellText(index: indexPath) {
                cell.cellLabel.text = "\(releaseDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getNowPlayingCellImage(index: indexPath)
        } else if collectionView == popularCollectionView {
            if let releaseDate = presenter?.getPopularCellText(index: indexPath) {
                cell.cellLabel.text = "\(releaseDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getPopularCellImage(index: indexPath)
        } else if collectionView == topRatedCollectionView {
            if let releaseDate = presenter?.getTopRatedCellText(index: indexPath) {
                cell.cellLabel.text = "\(releaseDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getTopRatedCellImage(index: indexPath)
        } else if collectionView == upcomingCollectionView {
            if let releaseDate = presenter?.getUpcomingCellText(index: indexPath) {
                cell.cellLabel.text = "\(releaseDate.prefix(4))"
            }
            cell.cellImageView.image = presenter?.getUpcomingCellImage(index: indexPath)
        }
        return cell
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
}


