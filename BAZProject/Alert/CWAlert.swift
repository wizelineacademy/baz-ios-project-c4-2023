//
//  CWAlert.swift
//  BAZProject
//
//  Created by nmorenoa on 30/03/23.
//

import UIKit
class CWAlert{
    
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
