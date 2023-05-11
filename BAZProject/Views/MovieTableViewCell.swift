//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by jmgarciaca on 12/04/23.
//

import UIKit

/// The MovieTableViewCell class represents a table view cell that displays movie information.
/// This class uses the MovieViewModel class to represent the movie information and the ImageLoader class to load the movie poster image from a URL.
final class MovieTableViewCell: UITableViewCell {
    
    /// The ImageLoader object used to load the movie poster image from a URL.
    private let imageLoader: ImageLoader = ImageLoader()
    
    /// The identifier used by this cell.
    static let identifier = String(describing: MovieTableViewCell.self)
    
    /// The view model representing the movie information.
    var movieVM: MovieViewModel?
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    /// Initializes the cell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessoryType = .disclosureIndicator
    }
}

extension MovieTableViewCell {
    
    ///  Sets up the cell with the specified movie view model.
    ///  - Parameter movieVM: The view model containing the movie information to display.
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
