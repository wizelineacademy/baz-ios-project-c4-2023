//
//  DetailRemoteDataMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import Foundation
@testable import BAZProject

class DetailRemoteDataMock: DetailRemoteData {
    
    var personDetails: PersonDetailDataObject?
    var movieDetails: MovieDetailDataObject?
    var tvDetails: TVDetailDataObject?
    var error: Error?
    
    override func getPersonDetails(id: Int) async throws -> PersonDetailDataObject? {
        if let error = error {
            throw error
        } else {
            return personDetails
        }
    }
    
    override func getTVDetails(id: Int) async throws -> TVDetailDataObject? {
        if let error = error {
            throw error
        } else {
            return tvDetails
        }
    }
    
    override func getMovieDetails(id: Int) async throws -> MovieDetailDataObject? {
        if let error = error {
            throw error
        } else {
            return movieDetails
        }
    }
    
}
