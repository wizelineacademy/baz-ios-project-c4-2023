//
//  CollectionReviewsCell.swift
//  BAZProject
//
//  Created by nmorenoa on 29/04/23.
//

import UIKit

final class CollectionReviewsCell: UICollectionViewCell{
    
    //MARK: Static Properties
    public class var nib: UINib {
        return UINib(nibName: CollectionReviewsCell.identifier,
                     bundle: nil)
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblReview: UILabel!
    
    //MARK: Lifecycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
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
