//
//  CollectionRecomendationsCell.swift
//  BAZProject
//
//  Created by nmorenoa on 29/04/23.
//

import UIKit
///   /// UICollectionViewCell - Recomendations or Similars
///
///  This Generic cell shows information about the Recomendations or Similars
///
/// - Returns:
///   - lblTitle: shows the title of the information.
///   - imgPoster:  show a image.
///
final class CollectionRecomendationsCell: UICollectionViewCell{
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    
    
    //MARK: - Static Properties
    public class var nib: UINib {
        return UINib(nibName: CollectionRecomendationsCell.identifier,
                     bundle: nil)
    }
    
    //MARK: - Lifecycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Functions
    /// this function sets the object information to the properties
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
