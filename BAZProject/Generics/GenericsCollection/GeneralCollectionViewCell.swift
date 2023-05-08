//
//  GeneralCollectionViewCell.swift
//  BAZProject
//
//  Created by Ben Frank V. on 06/05/23.
//

import UIKit

class GeneralCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var uvContent: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension GeneralCollectionViewCell: GeneralTableViewCellProtocol{
    func setup(_ movie: Movie?) {
        uvContent.layer.cornerRadius = 8
        imgPoster.layer.cornerRadius = 8
        imgPoster.clipsToBounds = true
        lblTitle.text = movie?.title
        getPoster(movie?.backdrop_path ?? "")
    }
    
    func getPoster(_ path: String) {
        GetImage.getImage(pathPoster: path) { image in
            DispatchQueue.main.async { [weak self] in
                if let poster = image {
                    self?.imgPoster.image = poster
                }else{
                    self?.imgPoster.image = UIImage(named: "poster")
                }
                
            }
            
        }
    }
}

