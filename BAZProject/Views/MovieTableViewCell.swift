//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by jmgarciaca on 12/04/23.
//

import UIKit

protocol MovieTableViewCellProtocols {
    func didTapCell()
}

class MovieTableViewCell: UITableViewCell {
    
    private let imageLoader: ImageLoader = ImageLoader()
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        print("Hola!!!")
    }
    
}

extension MovieTableViewCell {
    
    func setup(_ movieVM:MovieViewModel) {
        lblDescription.text = movieVM.title
        imgView.image = UIImage(named: "poster")
        
        if let url = URL(string: movieVM.poster_path) {
            imageLoader.getImage(from: url) { [weak self] image in
                self?.imgView.image = image
            }
        }
    }
}
