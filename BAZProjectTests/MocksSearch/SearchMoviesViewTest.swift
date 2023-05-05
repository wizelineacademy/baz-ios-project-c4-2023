//
//  SearchMoviesViewTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 21/04/23.
//

import XCTest
@testable import BAZProject

final class SearchMoviesViewTest: XCTestCase {
    
    var sut         : SearchMoviesView!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = SearchMoviesView()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    // MARK: View - Test
    // Validate backgroundColor of the view
    func test_SearchMoviesView_BackgroundColor() {
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }
    
    // Validate title is nil
    func test_SearchMoviesViewTitleIsNotNil() {
        XCTAssertNil(sut.title)
    }
    
    // validate title is empety
    func test_SearchMoviesViewIsEmptyTitle() {
        //Given
        let expected = ""
        //When
        let titleNav = sut.title ?? ""
        //Then
        XCTAssertEqual(expected, titleNav)
    }
    
    // MARK: Button - Test
    func test_ButtonSearchHasSetDelegate() {
        XCTAssertNotNil(sut.searchBar.delegate)
    }
    
    // MARK: TableView - Test
    func test_TableViewHasSetDatasource() {
        XCTAssertNotNil(sut.tblSearch.dataSource)
    }
    
    func test_TableView_WhenCellRowHasZeroElements(){
        XCTAssertEqual(sut.tblSearch.dataSource?.tableView(sut.tblSearch, numberOfRowsInSection: 0), 0)
    }
    
    func testMovieCellIsResetWhenIsReused() throws {
        // Given
        let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), style: .plain)
        let itemXib = UINib.init(nibName: "CellMovies",
                                 bundle: nil)
        tableView.register(itemXib,
                           forCellReuseIdentifier: "CellMovies")
        let movies = getMovies()
        let dataSource = SearchTableViewDataSourceMock(movies: movies)
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        //WHen
        let indexPath0 = IndexPath(item: 0, section: 0)
        let sut = tableView.cellForRow(at: indexPath0) as! CellMovies
        
        // Then
        XCTAssertNotNil(sut.descriptionMovie.text)
        XCTAssertEqual(sut.descriptionMovie.text, "Spiderman")
    }
    
    // Creation Mock array 'MoviewData'
    func getMovies() -> [MovieData] {
        let popularMovies: [MoviesViewModels] = [MoviesViewModels(title: "Spiderman", poster_path: "/path/Spiderman.jpg", original_title: "Spiderman", id: 2, overview: "pelicula Spiderman"),
                                                 MoviesViewModels(title: "Batman", poster_path: "/path/Batman.jpg", original_title: "Batman", id: 2, overview: "pelicula Batman")]
        return popularMovies
    }

}
class SearchTableViewDataSourceMock: NSObject, UITableViewDataSource {
    
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
        /*infoCell.getImage(){ imagen in
            cell.imgMovie.image         = imagen
        }*/
        return cell
    }
    
}
