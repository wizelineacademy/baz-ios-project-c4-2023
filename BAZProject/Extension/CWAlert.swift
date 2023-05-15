//
//  CWAlert.swift
//  BAZProject
//
//  Created by nmorenoa on 30/03/23.
//

import UIKit

final class CWAlert{
    ///   /// UIAlertAction - AlertGeneric
    ///
    ///  alert generic to be reusable an alert message to user.
    ///
    /// - Parameters:
    ///   - title: title to be displayed in the alert by default is error
    ///   - message:  message to be displayed in the alert
    ///   - actionTitle: Title for the button that appears in the alert, by default it is Accept.
    ///
    /// - Returns: An UIAlertController
    static public func simpleWith(title        : String? = "Error",
                                  message      : String?,
                                  actionTitle  : String = "Aceptar",
                                  actionHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title         : title,
                                                message       : message ?? "",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title  : actionTitle,
                                                style  : .default) { alertController in
            actionHandler?(alertController)
        })
        return alertController
    }
    
}
