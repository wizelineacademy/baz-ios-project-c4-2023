//
//  MovieCellTests.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 25/04/23.
//

import XCTest
@testable import BAZProject

final class MovieCellTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    
    func testMovieCellIsResetWhenIsReused() throws {
        // Given
        let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), style: .plain)
        let itemXib = UINib.init(nibName: "CellMovies",
                                 bundle: nil)
        tableView.register(itemXib,
                           forCellReuseIdentifier: "CellMovies")
        let movies = getMovies()
        let dataSource = TableViewDataSourceMock(movies: movies)
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        //WHen
        let indexPath0 = IndexPath(item: 0, section: 0)
        let sut = tableView.cellForRow(at: indexPath0) as! CellMovies
        sut.prepareForReuse()
        
        // Then
        XCTAssertNil(sut.descriptionMovie.text)
    }
    
    // Creation Mock array 'MoviewData'
    func getMovies() -> [MovieData] {
        let popularMovies: [MoviesViewModels] = [MoviesViewModels(title: "Spiderman", poster_path: "/path/Spiderman.jpg", original_title: "Spiderman", id: 2, overview: "pelicula Spiderman"),
                                                 MoviesViewModels(title: "Batman", poster_path: "/path/Batman.jpg", original_title: "Batman", id: 2, overview: "pelicula Batman"),
                                                 MoviesViewModels(title: "Superman", poster_path: "/path/Superman.jpg", original_title: "Superman", id: 2, overview: "pelicula Superman"),
                                                 MoviesViewModels(title: "Thor", poster_path: "/path/Thor.jpg", original_title: "Thor", id: 2, overview: "pelicula Thor"),
                                                 MoviesViewModels(title: "Avatar", poster_path: "/path/Avatar.jpg", original_title: "Avatar", id: 2, overview: "pelicula Avatar"),
                                                 MoviesViewModels(title: "Thor", poster_path: "/path/Thor.jpg", original_title: "Thor", id: 2, overview: "pelicula Thor"),
                                                 MoviesViewModels(title: "AntMan", poster_path: "/path/AntMan.jpg", original_title: "AntMan", id: 2, overview: "pelicula AntMan")]
        return popularMovies
    }
}
class TableViewDataSourceMock: NSObject, UITableViewDataSource {
    
    let movies: [MovieData]
    init(movies: [MovieData]) {
        self.movies = movies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CellMovies", for: indexPath) as? CellMovies else {
            return UITableViewCell()
        }
        let infoCell                = movies[indexPath.row]
        cell.descriptionMovie.text  = infoCell.title
        if let posterPath = infoCell.poster_path{
            cell.imgMovie.download(poster_path: posterPath)
        }
        return cell
    }
    
}
