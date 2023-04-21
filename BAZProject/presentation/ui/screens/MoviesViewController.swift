//
//  MoviesViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 15/04/23.
//

import UIKit

// MARK: - Class
class MoviesViewController: ReusableViewController {

    // MARK: - Properties
    private let delegateFlowLayout = MoviesFlowLayout()

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
    
    private lazy var skwContent: UIStackView = {
        let skw = UIStackView()
        skw.axis = .vertical
        skw.spacing = 8
        skw.translatesAutoresizingMaskIntoConstraints = false
        return skw
    }()
    
    private func skwContentConstraints() {
        slwMainContent.addSubview(skwContent)
        skwContent.topAnchor.constraint(equalTo: slwMainContent.topAnchor).isActive = true
        skwContent.trailingAnchor.constraint(equalTo: slwMainContent.trailingAnchor, constant: -.dim8).isActive = true
        skwContent.bottomAnchor.constraint(equalTo: slwMainContent.bottomAnchor).isActive = true
        skwContent.leadingAnchor.constraint(equalTo: slwMainContent.leadingAnchor, constant: .dim8).isActive = true
        skwContent.widthAnchor.constraint(equalTo: slwMainContent.widthAnchor, constant: -.dim16).isActive = true
    }

    private lazy var lblTrendingMoviesText: UILabel = {
        return setupLabel("Tendencias")
    }()
    
    private lazy var clvTrendingMovies: UICollectionView = {
        return setupCollectionView()
    }()

    private func addlblTrendingMoviesTextAndClvTrendingMovies() {
        skwContent.addArrangedSubview(lblTrendingMoviesText)
        skwContent.addArrangedSubview(clvTrendingMovies)
        clvTrendingMovies.delegate = delegateFlowLayout
        clvTrendingMovies.dataSource = setupDataSourceAndConstraints(.trending, clvTrendingMovies)
    }
    
    private lazy var lblNowPlayingMoviesText: UILabel = {
        return setupLabel("Reproduciendo Ahora")
    }()
    
    private lazy var clvNowPlayingMovies: UICollectionView = {
        return setupCollectionView()
    }()
    
    private func addlblNowPlayingMoviesTextAndClvNowPlayingMovies() {
        skwContent.addArrangedSubview(lblNowPlayingMoviesText)
        skwContent.addArrangedSubview(clvNowPlayingMovies)
        clvNowPlayingMovies.delegate = delegateFlowLayout
        clvNowPlayingMovies.dataSource = setupDataSourceAndConstraints(.nowPlaying, clvNowPlayingMovies)
    }
    
    private lazy var lblPopularMoviesText: UILabel = {
        return setupLabel("Populares")
    }()
    
    private lazy var clvPopularMovies: UICollectionView = {
        return setupCollectionView()
    }()
    
    private func addlblPopularMoviesTextAndClvPopularMovies() {
        skwContent.addArrangedSubview(lblPopularMoviesText)
        skwContent.addArrangedSubview(clvPopularMovies)
        clvPopularMovies.delegate = delegateFlowLayout
        clvPopularMovies.dataSource = setupDataSourceAndConstraints(.popular, clvPopularMovies)
    }

    private lazy var lblTopRatedMoviesText: UILabel = {
        return setupLabel("Los más valorados")
    }()
    
    private lazy var clvTopRatedMovies: UICollectionView = {
        return setupCollectionView()
    }()
    
    private func addlblTopRatedMoviesTextAndClvTopRatedMovies() {
        skwContent.addArrangedSubview(lblTopRatedMoviesText)
        skwContent.addArrangedSubview(clvTopRatedMovies)
        clvTopRatedMovies.delegate = delegateFlowLayout
        clvTopRatedMovies.dataSource = setupDataSourceAndConstraints(.topRated, clvTopRatedMovies)
    }
    
    private lazy var lblUpcomingMoviesText: UILabel = {
        return setupLabel("Próximamente")
    }()
    
    private lazy var clvUpcomingMovies: UICollectionView = {
        return setupCollectionView()
    }()
    
    private func addlblUpcomingMoviesTextAndClvUpcomingMoviesConstraints() {
        skwContent.addArrangedSubview(lblUpcomingMoviesText)
        skwContent.addArrangedSubview(clvUpcomingMovies)
        clvUpcomingMovies.delegate = delegateFlowLayout
        clvUpcomingMovies.dataSource = setupDataSourceAndConstraints(.upcoming, clvUpcomingMovies)
    }
    
    private func setupLabel(_ text: String) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        let sizeFont: CGFloat = .dim24
        lbl.font = UIFont.boldSystemFont(ofSize: sizeFont)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    private func setupCollectionView() -> UICollectionView {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let clv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        let reuseIdentifier = NSStringFromClass(MovieItemAdapter.self)
        clv.register(MovieItemAdapter.self, forCellWithReuseIdentifier: reuseIdentifier)
        clv.backgroundColor = .white
        clv.translatesAutoresizingMaskIntoConstraints = false
        return clv
    }
    
    private func setupDataSourceAndConstraints(_ filter: Filters, _ collectionView: UICollectionView) -> MoviesDataSource {
        collectionView.widthAnchor.constraint(equalTo: skwContent.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: .dim220).isActive = true
        let dataSourceDelegate = MoviesDataSource()
        let repository: MoviesRepository = MoviesDataSourceRemote()
        let moviesViewModel = MoviesViewModel(repository)
        moviesViewModel.onMoviesUpdate = {
            DispatchQueue.main.async {
                dataSourceDelegate.updateItems(moviesViewModel.movies)
                collectionView.reloadData()
            }
        }
        moviesViewModel.fetchMovies(filter)
        return dataSourceDelegate
    }

    // MARK: - Override Functions
    override func setupView() {
        super.setupView()
        delegateFlowLayout.viewController = self
        slwMainContentConstraints()
        skwContentConstraints()
        
        addlblTrendingMoviesTextAndClvTrendingMovies()
        
        addlblNowPlayingMoviesTextAndClvNowPlayingMovies()
        
        addlblPopularMoviesTextAndClvPopularMovies()

        addlblTopRatedMoviesTextAndClvTopRatedMovies()
        addlblUpcomingMoviesTextAndClvUpcomingMoviesConstraints()
    }
}
