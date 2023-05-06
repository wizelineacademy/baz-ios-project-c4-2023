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

    @IBOutlet weak var imvBackPoster: UIImageView!
    @IBOutlet weak var lblTitleView: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblCast: UILabel!
    
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
        //<#code#>
    }
    
    func updateData() {
        //<#code#>
    }
    
    func getImage(_ linkPosterBack: String) {
        GetImage.getImage(pathPoster: linkPosterBack) { image in
            DispatchQueue.main.async { [weak self] in
                if let poster = image {
                    self?.imvBackPoster.image = poster
                }else{
                    self?.imvBackPoster.image = UIImage(named: "poster")
                }
                
            }
            
        }
    }
    
    func titleMovie(_ title: String) {
        DispatchQueue.main.async {
            self.lblTitleView.text = title
        }
    }
    
    func overview(_ overview: String) {
        DispatchQueue.main.async {
            self.lblOverview.text = overview
        }
        
    }
    
    func cast(_ cast: String) {
        DispatchQueue.main.async {
            self.lblCast.text = cast
        }
    }
    
}
