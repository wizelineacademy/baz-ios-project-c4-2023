//
//  CollectionRecomendationsCellTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 05/05/23.
//

import XCTest
@testable import BAZProject

final class CollectionRecomendationsCellTest: XCTestCase {
    
    override func setUp() {
          super.setUp()
    }
    
    func testDetailCollectionResetWhenIsReused() throws {
        // Given
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                layout.itemSize = CGSize(width: 60, height: 60)
        
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), collectionViewLayout: layout)
        
        let itemXib = UINib(nibName: CollectionRecomendationsCell.identifier,
                            bundle: nil)
        collectionView.register(itemXib,
                                forCellWithReuseIdentifier: CollectionRecomendationsCell.identifier)
        let dataSource = CollectionRecomendationsDataSourceTest(movies: getMovies())
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        
        //When
        let indexPath0 = IndexPath(item: 0, section: 0)
        XCTAssertNotNil(collectionView.dataSource?.collectionView(collectionView, cellForItemAt: indexPath0))
        
        let sut = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: indexPath0)
        sut?.prepareForReuse()
        //ReviewsMovieData
        
        // Then
        XCTAssertNotNil(sut)
        
    }
    
    // Creation Mock array 'InfoDetailData'
    func getMovies() -> [InfoDetailData] {
        
        let popularMovies: [InfoDetailModel] = [InfoDetailModel(title: "My Teacher Ate My Friend", posterPath: "/5MiVG39r82aYUAtvs3bTycmbewJ.jpg", overview: "Tomás, an 11-year-old boy living in his own fantasy world, must use his vast monster knowledge to fight against his new English teacher: a wicked woman who is, in fact, a child-eating monster."),
                                                   InfoDetailModel(title: "A", posterPath: "/4uOKZzRB615cIxcVi31pcsdFtSS.jpg", overview: "A young alcoholic ambient musician locks himself in his apartment on a dangerous seven day bender as he attempts to finish his upcoming album."),
                                                   InfoDetailModel(title: "The Super Mario Bros. Movie", posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi."),
                                                   InfoDetailModel(title: "Demon Slayer: Kimetsu no Yaiba - Tsuzumi Mansion Arc", posterPath: "/7syc6DmjSeUSNp4VSGELfHQW17Q.jpg", overview: "Tanjiro ventures to the south-southeast where he encounters a cowardly young man named Zenitsu Agatsuma. He is a fellow survivor from Final Selection and his sparrow asks Tanjiro to help keep him in line."),
                                                   InfoDetailModel(title: "A", posterPath: "/y3DH68oWOGMZ637tqYHfTGU4Bif.jpg", overview: "A film director fades away from the industry after the failed love with the heroine of his movie. After being rehabilitated, he learns that some people conspired his fall and decides to take revenge."),
                                                   InfoDetailModel(title: "John Wick: Chapter 4", posterPath: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg", overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.")]
        return popularMovies
    }

}
final class CollectionRecomendationsDataSourceTest: NSObject, UICollectionViewDataSource {
    
    let movies: [InfoDetailData]
    init(movies: [InfoDetailData]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionRecomendationsCell", for: indexPath) as? CollectionRecomendationsCell else { return UICollectionViewCell() }
        cell.setCell(with: movies[indexPath.row])
        return cell
    }
    
    
    
}
