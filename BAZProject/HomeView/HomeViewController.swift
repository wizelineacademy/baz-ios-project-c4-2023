//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 28/03/23.
//

import UIKit

protocol Viewable {
    func getTitle() -> String
    func getImagePath() -> String
    func getReleaseData() -> String
}

class HomeViewController: UIViewController {
    
    // MARK: Variables
    var presenter: ViewToPresenterProtocol?
    
    // MARK: UIElements
    @IBOutlet weak var collectionView_Home: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
    }
    
    private func initialConfiguration(){
        collectionView_Home.register(UINib(nibName: "MovieAppCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HomeViewCellId")
        collectionView_Home.dataSource = self
        // TODO: (SDA) Refactor provisional function to ensamble the to be Viper module
        self.ensambleModule()
        presenter?.getMoviesData()
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
        collectionView_Home.reloadData()
    }
}


