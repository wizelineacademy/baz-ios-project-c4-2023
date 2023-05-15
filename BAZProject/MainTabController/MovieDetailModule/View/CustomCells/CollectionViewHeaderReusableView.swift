//
//  CollectionViewHeaderReusableView.swift
//  BAZProject
//
//  Created by 989438 on 25/04/23.
//

import UIKit

final class CollectionViewHeaderReusableView: UICollectionReusableView, ReusableIdentifierProtocol {
    @IBOutlet weak var cellTitleLbl: UILabel!
    
    func setup(_ title: String) {
        cellTitleLbl.text = title
    }
}
