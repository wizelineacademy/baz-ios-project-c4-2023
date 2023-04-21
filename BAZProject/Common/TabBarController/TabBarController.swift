//
//  TabBarController.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 19/04/23.
//

import UIKit

final class TabBarController: UITabBarController {

    let viewModel = TabBarControllerViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers =  viewModel.setUpViewController()
    }
    

}
