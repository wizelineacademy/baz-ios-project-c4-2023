//
//  MovieViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 15/04/23.
//

import UIKit

// MARK: - Class
class MovieViewController: ReusableViewController {
    
    // MARK: - Properties
    private let movieViewModel: MovieViewModel
    private let moviesDelegateFlowLayout = MoviesFlowLayout()
    private let actorsDelegateFlowLayout = ActorsFlowLayout()
    
    // MARK: - Input/View and Constraints

    private lazy var slwMainContent: UIScrollView = {
        let slw = UIScrollView()
        slw.translatesAutoresizingMaskIntoConstraints = false
        return slw
    }()
    
    private func slwMainContentConstraints() {
        view.addSubview(slwMainContent)
        slwMainContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        slwMainContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        slwMainContent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        slwMainContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    private lazy var imgvPorter: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleToFill
        let placeHolder = UIImage(named: "poster")
        let posterPath = "\(Consts.END_POINTS.POSTER_PATH)\(movieViewModel.movie.posterPath ?? "")"
        imgv.loadAsync(from: posterPath.toUrl(), placeHolder: placeHolder)
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()

    private func imgvPorterConstraints() {
        slwMainContent.addSubview(imgvPorter)
        imgvPorter.topAnchor.constraint(equalTo: slwMainContent.topAnchor).isActive = true
        imgvPorter.trailingAnchor.constraint(equalTo: slwMainContent.trailingAnchor).isActive = true
        imgvPorter.leadingAnchor.constraint(equalTo: slwMainContent.leadingAnchor).isActive = true
        imgvPorter.heightAnchor.constraint(equalToConstant: .dim380).isActive = true
    }
    
    private lazy var skwContent: UIStackView = {
        let skw = UIStackView()
        skw.axis = .vertical
        skw.spacing = 8
        skw.translatesAutoresizingMaskIntoConstraints = false
        return skw
    }()
    
    private func skwContentConstraints() {
        slwMainContent.addSubview(skwContent)
        skwContent.topAnchor.constraint(equalTo: imgvPorter.bottomAnchor, constant: .dim8).isActive = true
        skwContent.trailingAnchor.constraint(equalTo: slwMainContent.trailingAnchor, constant: -.dim8).isActive = true
        skwContent.bottomAnchor.constraint(equalTo: slwMainContent.bottomAnchor).isActive = true
        skwContent.leadingAnchor.constraint(equalTo: slwMainContent.leadingAnchor, constant: .dim8).isActive = true
        skwContent.widthAnchor.constraint(equalTo: slwMainContent.widthAnchor, constant: -.dim16).isActive = true
    }

    private lazy var lblTitleMovie: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim20
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.boldSystemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = movieViewModel.movie.title
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var skwVoteAndDate: StackVoteAndDate = {
        let vote = movieViewModel.movie.voteAverage
        let date = movieViewModel.movie.releaseDate
        let skw = StackVoteAndDate(voteAverange: vote, releaseDate: date)
        skw.translatesAutoresizingMaskIntoConstraints = false
        return skw
    }()
    
    private lazy var lblOverviewMovie: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim16
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.systemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = movieViewModel.movie.overview
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var lblCastActorsText: UILabel = {
        return setupLabel(text: "Reparto de Actores")
    }()
    
    private lazy var clvActors: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let clv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        let reuseIdentifier = NSStringFromClass(ActorItemAdapter.self)
        clv.register(ActorItemAdapter.self, forCellWithReuseIdentifier: reuseIdentifier)
        clv.translatesAutoresizingMaskIntoConstraints = false
        return clv
    }()
    
    private func addlblCastActorsTextAndClvActors() {
        skwContent.addArrangedSubview(lblCastActorsText)
        skwContent.addArrangedSubview(clvActors)
        clvActors.widthAnchor.constraint(equalTo: skwContent.widthAnchor).isActive = true
        clvActors.heightAnchor.constraint(equalToConstant: .dim220).isActive = true
        clvActors.delegate = actorsDelegateFlowLayout
        clvActors.dataSource = setupActorDataSourceAndConstraints(clvActors)
    }
    
    private lazy var lblSimilarMoviesText: UILabel = {
        return setupLabel(text: "Películas similares")
    }()
    
    private lazy var clvSimilarMovies: UICollectionView = {
        return setupMovieCollectionView()
    }()
    
    private func addlblSimilarMoviesTextAndClvSimilarMovies() {
        skwContent.addArrangedSubview(lblSimilarMoviesText)
        skwContent.addArrangedSubview(clvSimilarMovies)
        clvSimilarMovies.delegate = moviesDelegateFlowLayout
        clvSimilarMovies.dataSource = setupMovieDataSourceAndConstraints(.similar, clvSimilarMovies)
    }
    
    private lazy var lblRecommendedMoviesText: UILabel = {
        return setupLabel(text: "Películas recomendadas")
    }()
    
    private lazy var clvRecommendedMovies: UICollectionView = {
        return setupMovieCollectionView()
    }()
    
    private func addlblRecommendedMoviesTextAndClvRecommendedMovies() {
        skwContent.addArrangedSubview(lblRecommendedMoviesText)
        skwContent.addArrangedSubview(clvRecommendedMovies)
        clvRecommendedMovies.delegate = moviesDelegateFlowLayout
        clvRecommendedMovies.dataSource = setupMovieDataSourceAndConstraints(.recommendations, clvRecommendedMovies)
    }
    
    private lazy var lblMovieReviewsText: UILabel = {
        return setupLabel(text: "Reseñas de la película")
    }()
    
    private lazy var tvwReviews: UITableView = {
        let tvw = UITableView()
        tvw.separatorStyle = .singleLine
        tvw.isScrollEnabled = false
        tvw.rowHeight = UITableView.automaticDimension
        let reuseIdentifier = NSStringFromClass(ReviewItemAdapter.self)
        tvw.register(ReviewItemAdapter.self, forCellReuseIdentifier: reuseIdentifier)
        tvw.translatesAutoresizingMaskIntoConstraints = false
        return tvw
    }()
    
    private func tvwReviewsConstraints() {
        skwContent.addArrangedSubview(lblMovieReviewsText)
        skwContent.addArrangedSubview(tvwReviews)
        self.tvwReviews.widthAnchor.constraint(equalTo: skwContent.widthAnchor).isActive = true
        let delegates = ReviewsDelegate()
        tvwReviews.dataSource = setupReviewDataSourceAndConstraints(delegates)
        tvwReviews.delegate = delegates
    }
    
    private func setupLabel(text: String) -> UILabel {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim20
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.boldSystemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = text
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    private func setupActorDataSourceAndConstraints(_ collectionView: UICollectionView) -> ReusableCollectionViewDataSource<ActorItemAdapter, Actor> {
        let dataSourceDelegate = ReusableCollectionViewDataSource<ActorItemAdapter, Actor>()
        dataSourceDelegate.message = "No hay actores disponibles"
        movieViewModel.onCharactersUpdate = {
            DispatchQueue.main.async {
                dataSourceDelegate.updateItems(self.movieViewModel.characters)
                collectionView.reloadData()
            }
        }
        movieViewModel.fetchCharacters()
        return dataSourceDelegate
    }
    
    private func setupMovieCollectionView() -> UICollectionView {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let clv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        let reuseIdentifier = NSStringFromClass(MovieItemAdapter.self)
        clv.register(MovieItemAdapter.self, forCellWithReuseIdentifier: reuseIdentifier)
        clv.backgroundColor = .white
        clv.translatesAutoresizingMaskIntoConstraints = false
        return clv
    }
    
    private func setupMovieDataSourceAndConstraints(_ filter: Filters, _ collectionView: UICollectionView) -> MoviesDataSource {
        collectionView.widthAnchor.constraint(equalTo: skwContent.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: .dim220).isActive = true
        let dataSourceDelegate = MoviesDataSource()
        dataSourceDelegate.message = "No hay peliculas disponibles"
        let repository: MoviesRepository = MoviesDataSourceRemote()
        let moviesViewModel = MoviesViewModel(repository)
        moviesViewModel.onMoviesUpdate = {
            DispatchQueue.main.async {
                dataSourceDelegate.updateItems(moviesViewModel.movies)
                collectionView.reloadData()
            }
        }
        moviesViewModel.fetchRelatedMovies(filter, movieViewModel.movie.id)
        return dataSourceDelegate
    }
    
    private func setupReviewDataSourceAndConstraints(_ delegates: ReviewsDelegate) -> ReusableTableViewDataSource<ReviewItemAdapter, Review> {
        let dataSourceDelegate = ReusableTableViewDataSource<ReviewItemAdapter, Review>()
        dataSourceDelegate.message = "No hay reseñas disponibles"
        movieViewModel.onReviewsUpdate = {
            DispatchQueue.main.async {
                let reviews = self.movieViewModel.reviews
                dataSourceDelegate.updateItems(reviews)
                delegates.height = delegates.height * CGFloat(reviews.count)
                self.tvwReviews.heightAnchor.constraint(equalToConstant: delegates.height).isActive = true
                self.tvwReviews.reloadData()
            }
        }
        movieViewModel.fetchReviews()
        return dataSourceDelegate
    }
    
    init(movie: Movie) {
        let repository: MovieRepository = MovieDataSourceRemote()
        movieViewModel = MovieViewModel(movie: movie, repository: repository)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Functions
    override func setupView() {
        super.setupView()
        self.navigationController?.navigationBar.topItem?.title = "Movies"
        slwMainContentConstraints()
        imgvPorterConstraints()
        skwContentConstraints()
        
        skwContent.addArrangedSubview(lblTitleMovie)
        skwContent.addArrangedSubview(skwVoteAndDate)
        skwContent.addArrangedSubview(lblOverviewMovie)
        addlblCastActorsTextAndClvActors()
        
        addlblSimilarMoviesTextAndClvSimilarMovies()
        addlblRecommendedMoviesTextAndClvRecommendedMovies()
        
        tvwReviewsConstraints()
    }

}
