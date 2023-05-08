//
//  FavouritesViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 08/05/23.
//

import XCTest
@testable import BAZProject

final class FavouritesViewModelTests: XCTestCase {
    
    func test_getLocalData_ShouldReturnMockedData() throws {
        let decoder = DecoderSpy()
        let udMock = UserDefaultsMock()
        let data = [MediaItem(id: 1), MediaItem(id: 2), MediaItem(id: 3)]
        udMock.data = try JSONEncoder().encode(data)
        let local = FavouritesLocalData(udManager: udMock, decoder: decoder)
        let sut = FavouritesViewModel(localData: local)
        
        let retrievedData = sut.getLocalData()
        
        XCTAssertEqual(retrievedData, data)
    }
    
    func test_getLocalData_ShouldEncounterError() throws {
        let decoder = DecoderSpy()
        let expectedError = NSError(domain: "MammaMia!", code: -123)
        decoder.error = expectedError
        let udMock = UserDefaultsMock()
        let data = [MediaItem(id: 1), MediaItem(id: 2), MediaItem(id: 3)]
        udMock.data = try JSONEncoder().encode(data)
        let local = FavouritesLocalData(udManager: udMock, decoder: decoder)
        let sut = FavouritesViewModel(localData: local)
        let expectation = XCTestExpectation()
        var errorHolder: NSError?
        
        let _ = sut.getLocalData()
        sut.bindError { error in
            errorHolder = error as? NSError
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(errorHolder, expectedError)
    }
    
    func test_loadFavourites_ShouldReturnMockedData() throws {
        let decoder = DecoderSpy()
        let udMock = UserDefaultsMock()
        let data = [MediaItem(id: 1), MediaItem(id: 2), MediaItem(id: 3)]
        udMock.data = try JSONEncoder().encode(data)
        let local = FavouritesLocalData(udManager: udMock, decoder: decoder)
        let sut = FavouritesViewModel(localData: local)
        let expectation = XCTestExpectation()
        var snapshotHolder = NSDiffableDataSourceSnapshot<Int, MediaItem>()
        
        sut.loadFavourites()
        sut.bindSnapshot() { snapshot in
            snapshotHolder = snapshot
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(snapshotHolder.numberOfItems, data.count)
    }
    
    func test_removeFavourite_ShouldRemoveFavouriteFromSnapshotAndUDManager() throws {
        let decoder = DecoderSpy()
        let udMock = UserDefaultsMock()
        let item1 = MediaItem(id: 1)
        var data = [MediaItem(id: 2), MediaItem(id: 3)]
        data.append(item1)
        udMock.data = try JSONEncoder().encode(data)
        let local = FavouritesLocalData(udManager: udMock, decoder: decoder)
        let sut = FavouritesViewModel(localData: local)
        let expectation = XCTestExpectation()
        var snapshotHolder = NSDiffableDataSourceSnapshot<Int, MediaItem>()
        
        sut.loadFavourites()
        sut.removeFavourite(item1)
        sut.bindSnapshot { snapshot in
            snapshotHolder = snapshot
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
        let udData = sut.getLocalData()

        XCTAssertEqual(snapshotHolder.numberOfItems, data.count - 1)
        XCTAssertNil(snapshotHolder.sectionIdentifier(containingItem: item1))
        XCTAssertFalse(udData?.contains(item1) ?? true)
    }
    
    func test_removeFavourite_ShouldNotRemoveOnError() throws {
        let decoder = DecoderSpy()
        let encoder = EncoderSpy()
        let udMock = UserDefaultsMock()
        let item1 = MediaItem(id: 1)
        var data = [MediaItem(id: 2), MediaItem(id: 3)]
        data.append(item1)
        udMock.data = try JSONEncoder().encode(data)
        let local = FavouritesLocalData(udManager: udMock, decoder: decoder, encoder: encoder)
        let sut = FavouritesViewModel(localData: local)
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        var snapshotHolder = NSDiffableDataSourceSnapshot<Int, MediaItem>()
        let errorMario = NSError(domain: "It's-aMeMario", code: -12345)
        
        sut.loadFavourites()
        encoder.error = errorMario
        sut.removeFavourite(item1)
        sut.bindSnapshot { snapshot in
            snapshotHolder = snapshot
            expectation.fulfill()
        }
        sut.bindError { error in
            XCTAssertEqual(error as? NSError, errorMario)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
        let udData = sut.getLocalData()

        XCTAssertEqual(snapshotHolder.numberOfItems, data.count)
        XCTAssertEqual(snapshotHolder.sectionIdentifier(containingItem: item1), 0)
        XCTAssertTrue(udData!.contains(item1))
    }
    
    func test_getDetailView_shouldReturnNil() {
        let local = FavouritesLocalData(udManager: UserDefaultsMock(), decoder: DecoderSpy(), encoder: EncoderSpy())
        let sut = FavouritesViewModel(localData: local)
        
        let vc = sut.getDetailView(for: MediaItem())
        
        XCTAssertNil(vc)
    }
    
    func test_getDetailView_shouldReturnVC() {
        let local = FavouritesLocalData(udManager: UserDefaultsMock(), decoder: DecoderSpy(), encoder: EncoderSpy())
        let sut = FavouritesViewModel(localData: local)
        
        let vc = sut.getDetailView(for: MediaItem(id: 1, mediaType: .movie))
        
        XCTAssertNotNil(vc)
    }
}
