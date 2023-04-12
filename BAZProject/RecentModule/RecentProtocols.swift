//
//  RecentProtocols.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation
import UIKit

protocol RecentViewProtocol: AnyObject {
    var presenter: RecentPresenterProtocol? { get set }
}

protocol RecentWireFrameProtocol: AnyObject {
    static func createRecentModule() -> UIViewController
}

protocol RecentPresenterProtocol: AnyObject {
    var view: RecentViewProtocol? { get set }
    var interactor: RecentInteractorInputProtocol? { get set }
    var wireFrame: RecentWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol RecentInteractorOutputProtocol: AnyObject {
}

protocol RecentInteractorInputProtocol: AnyObject {
    var presenter: RecentInteractorOutputProtocol? { get set }
    var localDatamanager: RecentLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: RecentRemoteDataManagerInputProtocol? { get set }
}

protocol RecentDataManagerInputProtocol: AnyObject {
}

protocol RecentRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: RecentRemoteDataManagerOutputProtocol? { get set }
}

protocol RecentRemoteDataManagerOutputProtocol: AnyObject {
}

protocol RecentLocalDataManagerInputProtocol: AnyObject {
}
