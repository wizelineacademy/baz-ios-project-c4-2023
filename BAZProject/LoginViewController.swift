//
//  LoginViewController.swift
//  BAZProject
//
//  Created by ksolano on 21/04/23.
//

import UIKit

final class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // We show our Home module (VIPER)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let homeView = HomeRouter.createModule()
            self.navigationController?.pushViewController(homeView, animated: true)
        }
    }
    
}
