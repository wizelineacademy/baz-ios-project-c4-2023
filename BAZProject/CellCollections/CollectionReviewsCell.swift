//
//  CollectionReviewsCell.swift
//  BAZProject
//
//  Created by nmorenoa on 29/04/23.
//

import UIKit
///   /// UICollectionViewCell - CollectionReviewsCell
///
///  This cell shows information about the reviews
///
/// - Returns:
///   - lblUser: shows the author.
///   - imgUser:  show the image of the author
///   - lblReview: show author comment
///
final class CollectionReviewsCell: UICollectionViewCell{
    
    //MARK: - Static Properties
    public class var nib: UINib {
        return UINib(nibName: CollectionReviewsCell.identifier,
                     bundle: nil)
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblReview: UILabel!
    
    //MARK: - Lifecycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Functions
    /// this function sets the object information to the properties
    func setCell(with infoReview: ReviewsMovieData?){
        lblUser.text    = infoReview?.author ?? ""
        lblReview.text  = infoReview?.content ?? ""
        imgUser.image   = UIImage(named: "user")
        if let avatarPath = infoReview?.avatar_path{
            imgUser.download(poster_path: avatarPath)
            imgUser.makeRounded()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgUser.image   = nil
        lblReview.text  = nil
        lblUser.text    = nil
    }
    
    
}
