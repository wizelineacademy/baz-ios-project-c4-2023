//
//  DetailMovieView.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation
import UIKit

class DetailMovieView: UIViewController {

    // MARK: Properties
    var presenter: DetailMoviePresenterProtocol?

    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.willFetchDetailsMovie()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension DetailMovieView: DetailMovieViewProtocol {
    func registrerCell() {
       // <#code#>
    }
    
    func updateData(_ result: [Movie]) {
      //  <#code#>
    }
}
