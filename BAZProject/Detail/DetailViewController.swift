//
//  DetailViewController.swift
//  BAZProject
//
//  Created by jehernandezg on 03/05/23.
//

import UIKit

class DetailViewController: UIViewController/*, UITableViewDelegate, UISearchBarDelegate*/ {
    // MARK: Properties
    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.sizeToFit()
        scroll.backgroundColor = .clear
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.backgroundColor = .clear
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var movieView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .redraw
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "loader")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var movieTitle: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    private lazy var movieDate: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        return label
    }()
    private lazy var overview: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    private lazy var originalLanguage: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        return label
    }()
    private lazy var popularity: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        return label
    }()
    private lazy var voteAverage: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        return label
    }()
    private lazy var voteCount: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        return label
    }()
    private lazy var similarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3.3, height: 170)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(DetailMovieCell.self, forCellWithReuseIdentifier: "DetailMovieCell")
        return collection
    }()
    var presenter: DetailViewOutputProtocol?
    
    private var detailMovieModel: ListMovieProtocol?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.AppColors.homeCellBackgroundColor
        presenter?.getDetailMovie()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieView.image = UIImage(named: "poster")
        navigationItem.title = detailMovieModel?.title
        self.movieTitle.text = "Original Title: \(detailMovieModel?.originalTitle ?? detailMovieModel?.title ?? "")"
        self.movieDate.text = "Release Date: \(detailMovieModel?.releaseDate ?? "")"
        self.overview.text = "Overview:\n\(detailMovieModel?.overview ?? "")"
        self.originalLanguage.text = "Original Languaje: \(detailMovieModel?.originalLanguage?.capitalized ?? "")"
        self.popularity.text = "Popularity: \(detailMovieModel?.popularity ?? 0.0)"
        self.voteAverage.text = "Vote Average: \(detailMovieModel?.voteAverage ?? 0.0)"
        self.voteCount.text = "Vote Count: \(detailMovieModel?.voteCount ?? 0)"
    }
    
    // MARK: Functions
    private func setupView() {
        self.view.addSubview(scroll)
        scroll.addSubview(container)
        container.addSubview(stackView)
        stackView.addArrangedSubview(movieView)
        stackView.addArrangedSubview(movieTitle)
        stackView.addArrangedSubview(movieDate)
        stackView.addArrangedSubview(overview)
        stackView.addArrangedSubview(originalLanguage)
        stackView.addArrangedSubview(popularity)
        stackView.addArrangedSubview(voteAverage)
        stackView.addArrangedSubview(voteCount)
        stackView.addArrangedSubview(similarCollectionView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        let contentScroll = scroll.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            scroll.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            scroll.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            container.topAnchor.constraint(equalTo: contentScroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentScroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentScroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentScroll.bottomAnchor),
            container.widthAnchor.constraint(equalTo: contentScroll.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scroll.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            
            movieView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 8),
            movieView.heightAnchor.constraint(equalToConstant: 320),
            movieView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-32),
            movieView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            movieView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            
            similarCollectionView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
}

// MARK: - Extensions

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMovieCell", for: indexPath) as! DetailMovieCell
        //guard let source = presenter.getProducers() else { return cell }
        //cell.model = source[indexPath.row]
        cell.producersTitle.text = "Celda"
        return cell
    }
    
    
}

// MARK: - P R E S E N T E R · T O · V I E W
extension DetailViewController: DetailViewInputProtocol {
    func showDetailMovie(detailMovie: ListMovieProtocol) {
        //navigationItem.title = detailMovie.title
        self.detailMovieModel = detailMovie
    }
    
}

