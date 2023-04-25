//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 28/03/23.
//

import UIKit

// TODO: (SDA) Moverlo al archivo de protocolos? !!!!
protocol Viewable {
    func getTitle() -> String
    func getImagePath() -> String
    func getReleaseData() -> String
}

class HomeViewController: UIViewController {
    
    // MARK: Variables
    var presenter: ViewToPresenterProtocol?
    var networkManager = NetworkManager()
    
    // MARK: UIElements
    @IBOutlet weak var collectionView_Home: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
        presenter?.getMoviesData()
        networkManager.getNewMovies(page: 1) { movies, error in
            print("Ya hemos consumido el nuevo servicio con la capa de networking")
        }
    }
    
    private func initialConfiguration(){
        collectionView_Home.register(UINib(nibName: "MovieAppCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HomeViewCellId")
        collectionView_Home.dataSource = self
        // TODO: (SDA) Refactor provisional function to ensamble the to be Viper module
        self.ensambleModule()
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
        guard let numberOfItems = presenter?.getNumberOfItems() else { return 0 }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCellId", for: indexPath) as? MovieAppCollectionViewCell else { return UICollectionViewCell() }
        cell.cellLabel.text = presenter?.getCellText(index: indexPath)
        return cell
    }
}

// MARK: PresenterToViewProtocol Extension
extension HomeViewController: PresenterToViewProtocol {
    func reloadView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView_Home.reloadData()
        }
    }
}


