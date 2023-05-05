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
    private var heightReviews: NSLayoutConstraint!

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
        return setupLabel(text: "castText".localized)
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
        return setupLabel(text: "similarMoviesText".localized)
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
        return setupLabel(text: "recommendedMoviesText".localized)
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
        return setupLabel(text: "movieReviewsText".localized)
    }()

    private func setupLabel(text: String, _ sizeFont: CGFloat = .dim20) -> UILabel {
        let lbl = UILabel()
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
        dataSourceDelegate.message = "actorsEmptyText".localized
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
        dataSourceDelegate.message = "moviesEmptyText".localized
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

    private func loadReviews() {
        movieViewModel.onReviewsUpdate = {
            DispatchQueue.main.async {
                let reviews = self.movieViewModel.reviews
                if reviews.count > 0 {
                    reviews.forEach { review in
                        let reviewItem = ReviewItemView(review: review)
                        self.skwContent.addArrangedSubview(reviewItem)
                    }
                } else {
                    let lblReviewsEmpty = self.setupLabel(text: "reviewsEmptyText".localized, .dim16)
                    lblReviewsEmpty.textAlignment = .center
                    self.skwContent.addArrangedSubview(lblReviewsEmpty)
                }
                self.skwContent.layoutIfNeeded()
            }
        }
        movieViewModel.fetchReviews()
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
        self.navigationController?.navigationBar.topItem?.title = "moviesText".localized
        slwMainContentConstraints()
        imgvPorterConstraints()
        skwContentConstraints()

        skwContent.addArrangedSubview(lblTitleMovie)
        skwContent.addArrangedSubview(skwVoteAndDate)
        skwContent.addArrangedSubview(lblOverviewMovie)
        addlblCastActorsTextAndClvActors()

        addlblSimilarMoviesTextAndClvSimilarMovies()
        addlblRecommendedMoviesTextAndClvRecommendedMovies()
        skwContent.addArrangedSubview(lblMovieReviewsText)
        loadReviews()
    }
}
