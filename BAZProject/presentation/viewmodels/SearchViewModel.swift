//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 27/04/23.
//

import Foundation

// MARK: - Protocol
protocol SearchDelegate: AnyObject {
    func searchResults()
}

// MARK: - Class
class SearchViewModel {

    // MARK: - public variables
    var sectionTitles: [String] = []
    var movies: [Movie] = []
    var keywords: [String] = []
    weak var delegate: SearchDelegate?

    // MARK: - private variables
    private let repository: SearchRepository

    init(_ repository: SearchRepository) {
        self.repository = repository
    }

    // MARK: - public functions
    func fetchSearch(_ query: String) {
        let group = DispatchGroup()
        group.enter()
        repository.searchMovies(query: query) { movies in
            defer { group.leave() }
            self.movies = movies
        }
        group.enter()
        repository.searchKeyword(query: query) { keywords in
            defer { group.leave() }
            self.keywords = keywords
        }
        group.notify(queue: .main) {
            if self.movies.count > 0 && !self.sectionTitles.contains("moviesText".localized) {
                self.sectionTitles.append("moviesText".localized)
            }
            if self.keywords.count > 0 && !self.sectionTitles.contains("otherSuggestionsText".localized) {
                self.sectionTitles.append("otherSuggestionsText".localized)
            }
            self.delegate?.searchResults()
        }
    }
}
