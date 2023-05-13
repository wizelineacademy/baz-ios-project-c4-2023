//
//  MovieCellTests.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 12/05/23.
//

import XCTest
@testable import BAZProject

final class MovieCellTests: XCTestCase {

    var collectionMoviesView: UICollectionView!
    var collectionCastView: UICollectionView!
    var movies: [Movie]!
    var cast: [Cast]!
    
    override func setUp() {
        super.setUp()
        
        movies = [Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)]
        cast = [Cast(adult: false, gender: 0, id: 0, knownForDepartment: "ejemplo", name: "ejemplo", originalName: "ejemplo", popularity: 0, creditID: "ejemplo")]
        
    }
    
    func test_movieCell_isResetWhenIsReused() throws {
        // Given
        collectionMoviesView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), collectionViewLayout: UICollectionViewLayout())
        
        collectionMoviesView.register(UINib(nibName: MovieCollectionViewCell.idetifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.idetifier)
        let dataSource = CollectionViewMoviesDataSourceMock(movies: movies)
        collectionMoviesView.dataSource = dataSource
        collectionMoviesView.reloadData()
        
        //WHen
        let sut = collectionMoviesView.dataSource?.collectionView(collectionMoviesView, cellForItemAt: IndexPath(item: 0, section: 0)) as! MovieCollectionViewCell
        sut.prepareForReuse()
        
        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.lblTitle.text, "")
    }
    
    func test_castCell_isResetWhenIsReused() throws {
        // Given
        collectionCastView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), collectionViewLayout: UICollectionViewLayout())
        
        collectionCastView.register(UINib(nibName: CastCollectionViewCell.idetifier, bundle: nil), forCellWithReuseIdentifier: CastCollectionViewCell.idetifier)
        let dataSource = CollectionViewCastDataSourceMock(cast: cast)
        collectionCastView.dataSource = dataSource
        collectionCastView.reloadData()
        
        //WHen
        let sut = collectionCastView.dataSource?.collectionView(collectionCastView, cellForItemAt: IndexPath(item: 0, section: 0)) as! CastCollectionViewCell
    
        sut.prepareForReuse()
        
        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.lblName.text, "")
    }

}

class CollectionViewMoviesDataSourceMock: NSObject, UICollectionViewDataSource {
    let movies: [Movie]
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.idetifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let movie =  movies[indexPath.row]
        guard let url = movie.urlImage else { return UICollectionViewCell() }
        
        cell.imgPoster.loadRemoteImage(url: url)
        cell.lblTitle.text = movie.title
        
        return cell
    }
}

class CollectionViewCastDataSourceMock: NSObject, UICollectionViewDataSource {
    let cast: [Cast]
    init(cast: [Cast]) {
        self.cast = cast
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.idetifier, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
        let actor = cast[indexPath.row]
        guard let url = actor.urlProfilePath else { return UICollectionViewCell() }
        cell.imgActor.loadRemoteImage(url: url)
        cell.lblName.text = actor.name
        return cell
    }

}
