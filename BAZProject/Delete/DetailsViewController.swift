//
//  DetailsViewController.swift
//  BAZProject
//
//  Created by Carlos Garcia on 20/04/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var imgVwBackgroundCover: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblOverview: UILabel!
    @IBOutlet private weak var lblCast: UILabel!
    
    var movie: MovieInfo
    
    init(movie: MovieInfo) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        
        lblTitle.text = movie.title
        lblOverview.text = movie.overview
        lblCast.text = "Actor 1, Actor 2, Actor 3... más"
        
        self.imgVwBackgroundCover.image = UIImage(named: "poster")
        guard let strBackdropPath = movie.backdropPath else { return }
        ResourcesManager().downloadImage(from: strBackdropPath) { image in
            if let image = image {
                self.imgVwBackgroundCover.image = image
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Detalles"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
