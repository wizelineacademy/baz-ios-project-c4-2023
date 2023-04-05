//
//  ReusableViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import UIKit

class ReusableViewController: UIViewController {

    // MARK: - Override Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Publics Functions

    func setupView(){
        view.backgroundColor = .white
    }
}
