//
//  CollectionReviewsCellTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 05/05/23.
//

import XCTest
@testable import BAZProject

final class CollectionReviewsCellTest: XCTestCase {

    override func setUp() {
          super.setUp()
    }
    
    func testDetailCollectionResetWhenIsReused() throws {
        // Given
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                layout.itemSize = CGSize(width: 60, height: 60)
        
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), collectionViewLayout: layout)
        
        let itemXib = UINib(nibName: CollectionReviewsCell.identifier,
                            bundle: nil)
        collectionView.register(itemXib,
                                forCellWithReuseIdentifier: CollectionReviewsCell.identifier)
        let dataSource = CollectionReviewsDataSourceTest(movies: getMovies())
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
    
    // Creation Mock array 'MoviewData'
    func getMovies() -> [ReviewsInformation] {
        
        let popularMovies: [ReviewsInformation] = [ReviewsInformation(author: "MSB", avatar_path: "/https://secure.gravatar.com/avatar/992eef352126a53d7e141bf9e8707576.jpg", content: "FULL SPOILER-FREE REVIEW @ https://www.firstshowing.net/2023/review-dungeons-dragons-honor-among-thieves-is-a-delightful-surprise/\r\n\r\n\"DUNGEONS & DRAGONS: HONOR AMONG THIEVES is one of the best fantasy films of the most recent years."),
                                                   ReviewsInformation(author: "CinemaSerf", avatar_path: "/1kks3YnVkpyQxzw36CObFPvhL5f.jpg", content: "Now I really did enjoy this, but let\'s not for a moment pretend that it has much originality to it. We start with a scene borrowed from \"Jurassic Park\" (1993) before getting introduced to the wise-cracking \"Edgin\" (Chris Pine) who has been incarcerated in an impregnable prison with his pal \"Holga\" (Michelle Rodriguez)."),
                                                   ReviewsInformation(author: "Innovator", avatar_path: "/5U5amYZQ5TD9628GWvmjXtgZygT.jpg", content: "The numerous manuals on my shelves for 1st to 5e speak volumes of my familiarity with the game, as does the novels I own, and the numerous D&D computer games I\'ve played, so I was ecstatic seeing the places, people, and creatures I know very well."),
                                                   ReviewsInformation(author: "Louisa Moore - Screen Zealots", avatar_path: "/https://secure.gravatar.com/avatar/70d4177132896d293b72f4c595521141.jpg", content: "Based on the legendary role-playing game, “Dungeons & Dragons: Honor Among Thieves” is nothing like what I anticipated and much better than I expected. This irresistible fantasy adventure has a healthy dose of good humor, playful charm, and is easily accessible to all who love imaginary worlds filled with wizards, sorcerers, warlocks, knights, and fire-breathing dragons.\r\n\r\nCharismatic thief Edgin (Chris Pine) and his band of unlikely adventurers (including Holga (Michelle Rodriguez) the barbarian) undertake an epic heist to retrieve a lost relic and to liberate his daughter (Chloe Coleman) from Forge’s (Hugh Grant) castle. Things go dangerously awry when they run afoul of the wrong people, but the group must work together to overcome seemingly never-ending obstacles as they continue their important quest.\r\n\r\nWhile directors John Francis Daley and Jonathan Goldstein stay true to the origins of the game, prior knowledge of Dungeons & Dragons isn’t necessary. ")]
        return popularMovies
    }

    
    
}
class CollectionReviewsDataSourceTest: NSObject, UICollectionViewDataSource {
    
    let movies: [ReviewsInformation]
    init(movies: [ReviewsInformation]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionReviewsCell", for: indexPath) as? CollectionReviewsCell else { return UICollectionViewCell() }
        cell.setCell(with: movies[indexPath.row])
        return cell
    }
    
    
    
}
