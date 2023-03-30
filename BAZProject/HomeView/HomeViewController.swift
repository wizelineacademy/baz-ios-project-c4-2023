//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 28/03/23.
//

import UIKit

protocol HomeToViewProtocol {
    var interactor: PresenterToInteractor? { get set }
    
    func getMoviesData()
}

class HomeViewController: UIViewController {
    
    // MARK: Variables
    
    var presenter: HomeToViewProtocol?
    
    // MARK: UIElements
    
    @IBOutlet weak var collectionView_Home: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Initial configuration
        collectionView_Home.register(UINib(nibName: "MovieAppCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HomeViewCellId")
        collectionView_Home.dataSource = self
        
        // TODO: (SDA) La diguiente línea es equivalente a poner view.presenter = self, pero en la clase del Presenter, como no tenemos un inicializador o el router que arme todo, pues lo hacemos aqui, y con esta línea decimos que quien conforma el protocolo de comunicación es el presenter
        presenter = Presenter()
        presenter?.interactor = Interactor()
        print("Se pide al presenter que se obtengan los datos...")
        presenter?.getMoviesData()
    }
}

// MARK: Data source extension

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCellId", for: indexPath) as? MovieAppCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}


