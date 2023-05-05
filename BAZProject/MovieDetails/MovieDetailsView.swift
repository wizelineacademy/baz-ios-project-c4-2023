//
//  MovieDetailsView.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//  
//

import Foundation
import UIKit

class MovieDetailsView: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imgVwBackgroundCover: UIImageView! {
        didSet {
            self.imgVwBackgroundCover.image = UIImage(named: "poster")
            self.imgVwBackgroundCover.showActivityIndicator()
        }
    }
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblOverview: UILabel!
    @IBOutlet private weak var lblCast: UILabel!
    @IBOutlet private weak var scrllSectionButtons: UIScrollView!
    @IBOutlet private lazy var arrSectionButtons: [UIButton] = [] {
        didSet {
            for button in arrSectionButtons {
                configSectionButton(button)
            }
            arrSectionButtons.first(where: {$0.tag == 0})?.isSelected = true
        }
    }
    @IBOutlet private weak var tableViewSection: UITableView!
    @IBOutlet private weak var tableSectionHeight: NSLayoutConstraint!

    // MARK: Properties
    var presenter: MovieDetailsPresenterProtocol?
    private var subSectionSelected: DetailsSubSections = .review
    private var reviews: [MovieReviewInfo] = []
    private var similarMovies: [MovieInfo] = []
    private var recommendedMovies: [MovieInfo] = []
    private var isFavorite: Bool = false
    
    init(presenter: MovieDetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        presenter?.viewDidLoad()
    }
    
    private func configView() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.addRightButton(imageName: "heart", action: #selector(self.favoriteAction(_:)), color: .systemBlue)
        tableViewSection.register(UINib(nibName: MovieListCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: MovieListCell.reusableIdentifier)
        tableViewSection.delegate = self
        tableViewSection.dataSource = self
        tableViewSection.isScrollEnabled = false
        tableViewSection.bounces = false
        scrollView.bounces = false
        scrollView.delegate = self
    }
    
    private func configSectionButton(_ button: UIButton) {
        button.isSelected = false
        let btnTitle = button.titleLabel?.text ?? ""
        button.setAttributedTitle(getButtonAttributes(title: btnTitle, weight: .regular, titleColor: .black), for: .normal)
        button.setAttributedTitle(getButtonAttributes(title: btnTitle, weight: .light, titleColor: .lightGray), for: .highlighted)
        button.setAttributedTitle(getButtonAttributes(title: btnTitle, weight: .bold, titleColor: .black), for: .selected)
    }
    
    private func getButtonAttributes(title: String, weight: UIFont.Weight, titleColor: UIColor) -> NSAttributedString {
        NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: weight), .foregroundColor: titleColor])
    }
    
    private func setSectionButtonsToDeselectState() {
        for button in arrSectionButtons {
            button.isSelected = false
        }
    }
    
    private func configFavoriteButton() {
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
    }
    
    @objc private func favoriteAction(_ sender: Any) {
        isFavorite ? presenter?.removeFromFavorites() : presenter?.saveToFavorites()
    }
    
    @IBAction func showSectionButtonPressed(_ sender: UIButton) {
        setSectionButtonsToDeselectState()
        sender.isSelected = true
        let index = sender.tag
        let subSection = DetailsSubSections(rawValue: index) ?? .review
        switch subSection {
        case .review:
            scrllSectionButtons.scrollRectToVisible(sender.frame, animated: true)
            presenter?.showReviewSection()
        case .similar:
            scrllSectionButtons.scrollRectToVisible(sender.frame, animated: true)
            presenter?.showSimilarMoviesSection()
        case .recommendations:
            scrllSectionButtons.scrollRectToVisible(CGRect(x: self.view.frame.width, y: 0, width: sender.frame.width, height: 10), animated: true)
            presenter?.showRecommendationsSection()
        }
    }
}

extension MovieDetailsView: MovieDetailsViewProtocol {
    func setNavigationTitle(for strTitle: String?){
        navigationItem.title = strTitle
    }
    
    func showMovieData(_ movie: MovieDetailsInfo, castDescription: String?) {
        lblTitle.text = movie.title
        lblOverview.text = movie.overview
        lblCast.text = castDescription
        presenter?.getBackdropImage(with: movie.backdropPath)
    }
    
    func updateMovieCast(_ castDescription: String?) {
        lblCast.text = castDescription
    }
    
    func updateBackdropImage(_ image: UIImage) {
        imgVwBackgroundCover.image = image
        imgVwBackgroundCover.hideActivityIndicator()
    }
    
    func showMovieReviews(_ reviews: [MovieReviewInfo]) {
        self.reviews = reviews
        self.subSectionSelected = .review
        self.tableSectionHeight.constant = reviews.count > 0 ? self.scrollView.frame.height : 80
        self.tableViewSection.reloadData()
    }
    
    func showSimilarMovies(_ movies: [MovieInfo]) {
        self.similarMovies = movies
        self.subSectionSelected = .similar
        self.tableSectionHeight.constant = self.scrollView.frame.height
        self.tableViewSection.reloadData()
    }
    
    func showRecommendedMovies(_ movies: [MovieInfo]) {
        self.recommendedMovies = movies
        self.subSectionSelected = .recommendations
        self.tableSectionHeight.constant = self.scrollView.frame.height
        self.tableViewSection.reloadData()
    }
    
    func setFavoriteMovieIcon(to isFavorite: Bool) {
        self.isFavorite = isFavorite
        self.configFavoriteButton()
    }
}

extension MovieDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.subSectionSelected {
        case .review:
            return self.reviews.count > 0 ? self.reviews.count : 1
        case .similar:
            return self.similarMovies.count
        case .recommendations:
            return self.recommendedMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reusableIdentifier) as? MovieListCell else { return UITableViewCell() }
        
        switch self.subSectionSelected {
        case .review:
            let cell = UITableViewCell()
            var config = cell.defaultContentConfiguration()
            if let reviewInfo = reviews[safe: indexPath.row] {
                config.attributedText = NSAttributedString(string: reviewInfo.author, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor: UIColor.gray])
                config.secondaryText = "\n\(reviewInfo.content)"
            } else {
                config.text = "No se encontraron reseñas."
            }
            cell.contentConfiguration = config
            cell.selectionStyle = .none
            return cell
        case .similar:
            if let movieInfo = self.similarMovies[safe: indexPath.row] {
                movieCell.setData(with: movieInfo)
            }
        case .recommendations:
            if let movieInfo = self.recommendedMovies[safe: indexPath.row] {
                movieCell.setData(with: movieInfo)
            }
        }
        return movieCell
    }
}

extension MovieDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.subSectionSelected {
        case .similar:
            if let movieInfo = self.similarMovies[safe: indexPath.row] {
                presenter?.goToMovieDetails(for: movieInfo.id)
            }
        case .recommendations:
            if let movieInfo = self.recommendedMovies[safe: indexPath.row] {
                presenter?.goToMovieDetails(for: movieInfo.id)
            }
        default: return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.subSectionSelected {
        case .review:
            return UITableView.automaticDimension
        case .similar, .recommendations:
            return 120
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            if scrollView.contentOffset.y >= self.tableViewSection.frame.origin.y {
                self.tableViewSection.isScrollEnabled = true
            } else {
                self.tableViewSection.isScrollEnabled = false
            }
        }
    }
}
