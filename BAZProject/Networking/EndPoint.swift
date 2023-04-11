//
//  EndPoint.swift
//  BAZProject
//
//  Created by nmorenoa on 29/03/23.
//

import Foundation

protocol Endpoint{
    var baseURL         : String        { get }
    var path            : String        { get }
    var apiKey          : String        { get }
    var request         : URLRequest    { get }
    var url             : URL           { get }
}

