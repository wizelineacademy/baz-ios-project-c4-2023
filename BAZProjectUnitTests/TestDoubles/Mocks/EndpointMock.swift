//
//  EndpointsMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 30/03/23.
//

import Foundation
@testable import BAZProject

struct EndpointMock: EndpointProtocol {
    var request: URLRequest? = URLRequest(url: URL(string: "https://fakeurl.com")!)
}
