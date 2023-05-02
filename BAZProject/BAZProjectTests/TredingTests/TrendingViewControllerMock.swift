//
//  TrendingViewControllerMock.swift
//  BAZProjectTests
//
//  Created by Manuel S on 30/03/23.
//

//import Foundation
//@testable import BAZProject




import Foundation
@testable import BAZProject

final class SearchViewModelMock: SearchViewModel {

    var movies = [Movie]()
    
    override func searchMovie(_ title: String, apiKey: String, completion: @escaping (Error) -> Void ) {
       completion(NSError())
    }
    
    override func getMovieCount() -> Int {
        movies.count
    }
}
