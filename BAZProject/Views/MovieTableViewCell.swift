//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by jmgarciaca on 12/04/23.
//

import UIKit

/**
Protocol used by movie table view cells to notify their delegate that they have been tapped.
*/
protocol MovieTableViewCellProtocols {
    /**
      Notifies the delegate that the cell has been tapped.
      - Parameter movieVM: The view model of the movie associated with the tapped cell.
    */
    func didTapCell(_ movieVM: MovieViewModel?)
}

class MovieTableViewCell: UITableViewCell {
    
    /// The delegate for handling cell taps.
    var delegate:MovieTableViewCellProtocols!
    
    private let imageLoader: ImageLoader = ImageLoader()
    
    /// The view model representing the movie information.
    var movieVM: MovieViewModel?
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessoryType = .disclosureIndicator
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
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

    /**
      Handles when the cell is tapped by calling the delegate method to notify the controller.
    */
    @objc func didTap () {
        if self.delegate != nil {
            self.delegate.didTapCell(movieVM)
        }
    }
}
