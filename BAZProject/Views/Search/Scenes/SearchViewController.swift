//
//  SearchViewController.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 16/04/23.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    var interactor: SearchBusinessLogic? { get }
}

class SearchViewController: UIViewController {

    var interactor: SearchBusinessLogic?
    weak var router: SearchRouter?
    
}

extension SearchViewController: SearchDisplayLogic {
    
}
