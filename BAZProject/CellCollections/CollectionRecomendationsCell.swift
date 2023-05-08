//
//  CollectionRecomendationsCell.swift
//  BAZProject
//
//  Created by nmorenoa on 29/04/23.
//

import UIKit

final class CollectionRecomendationsCell: UICollectionViewCell{
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    
    
    //MARK: Static Properties
    public class var nib: UINib {
        return UINib(nibName: CollectionRecomendationsCell.identifier,
                     bundle: nil)
    }
    
    //MARK: Lifecycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setCell(with infoReview: InfoDetailData?){
        lblTitle.text   = infoReview?.title
        imgPoster.image = UIImage(named: "movie")
        if let posterPath = infoReview?.posterPath{
            imgPoster.download(poster_path: posterPath)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text           = nil
        imgPoster.image         = nil
    }
}
