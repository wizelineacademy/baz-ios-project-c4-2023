//
//  Storyboard.swift
//  BAZProject
//
//  Created by nmorenoa on 09/04/23.
//

import Foundation
import UIKit

protocol Storyboard {
    static func instantiate() -> Self?
}

extension Storyboard where Self: UIViewController {
    static func instantiate() -> Self? {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: id) as? Self
    }
}
extension UITableViewCell {
    class var identifier: String { return String(describing: self) }
}
