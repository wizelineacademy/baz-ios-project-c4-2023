//
//  GenericSHeetAlerts.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import UIKit

class Alerts {
    
    static func showActionsheet(viewController: UIViewController, title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void) {
    let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    for (index, (title, style)) in actions.enumerated() {
        let alertAction = UIAlertAction(title: title, style: style) { (_) in
            completion(index)
        }
        alertViewController.addAction(alertAction)
     }
     
     viewController.present(alertViewController, animated: true, completion: nil)
    }
}
