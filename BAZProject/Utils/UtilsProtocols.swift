//
//  UtilsProtocols.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 04/05/23.
//

import Foundation
import UIKit

protocol Viewable {
    var id: Int? { get }
    var title: String { get }
    var overview: String { get }
    var imagePath: String? { get }
    var additionalInfo: String? { get }
    
    func getId() -> Int?
    func getTitle() -> String
    func getOverview() -> String
    func getImagePath() -> String?
    func getAdditionalInfo() -> String?
}

protocol AlertPresentable {
    func showAlert(_ title: String, _ message: String)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            print("ALERT SHOWED")
        }))
        present(alert, animated: true)
    }
}
