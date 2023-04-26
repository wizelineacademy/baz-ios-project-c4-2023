//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by jmgarciaca on 12/04/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    private let imageLoader: ImageLoader = ImageLoader()
    
    /// The identifier used by this cell.
    static let identifier = String(describing: MovieTableViewCell.self)
    
    /// The view model representing the movie information.
    var movieVM: MovieViewModel?
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MovieTableViewCell {
    
    /**
      Sets up the cell with the specified movie view model.
     
      - Parameter movieVM: The view model containing the movie information to display.
    */
    func setup(_ movieVM:MovieViewModel) {
        lblDescription.text = movieVM.title
        imgView.image = UIImage(named: "poster")
        self.movieVM = movieVM
        
        if let url = URL(string: movieVM.poster_path ?? "") {
            imageLoader.getImage(from: url) { [weak self] image in
                self?.imgView.image = image
            }
        }
    }
}
