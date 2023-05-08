//
//  UIImageTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest

final class UIImageTests: XCTestCase {

    func test_init_DownloadData() async {
        let session = RequestSessionMock()
        session.data = DataStubs.imageData
        
        let image = try! await UIImage(endpoint: EndpointMock.forOtherTests, session: session)
        
        XCTAssertNotNil(image)
    }

}
