//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by jmgarciaca on 12/04/23.
//

import UIKit

protocol MovieTableViewCellProtocols {
    func didTapCell(_ movieVM: MovieViewModel?)
}

class MovieTableViewCell: UITableViewCell {
    var delegate:MovieTableViewCellProtocols!
    
    private let imageLoader: ImageLoader = ImageLoader()
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

    @objc func didTap () {
        if self.delegate != nil {
            self.delegate.didTapCell(movieVM)
        }
    }
    
}
