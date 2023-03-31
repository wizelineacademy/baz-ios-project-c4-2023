//
//  GenericSHeetAlerts.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import UIKit

class Alerts {
    /**
     Function to create a UIAlertController.
     
     - Parameters:
         - viewController: Represents the viewController that its going to show the AlertController.
         - title: Title of the UIAlertController.
         - message: Description of the UIAlertController.
         - actions: The options that it is going to have the UIAlertController.
         - completion: Returns the index of the selected option.
     
     ### showActionSheet Example: ###
     ````
     var actions: [(String, UIAlertAction.Style)] = []
     actions.append(("Trending", UIAlertAction.Style.default))
     actions.append(("Now Playing", UIAlertAction.Style.default))
     actions.append(("Cancel", UIAlertAction.Style.cancel))
     
     Alerts.showActionsheet(viewController: self, title: title, message: message, actions: actions) { index in
         print("OptioSelected: \(index)")
     }
     */
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
