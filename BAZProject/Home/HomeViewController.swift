//  HomeViewController.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

//MARK: - Class
class HomeViewController: UIViewController, UITableViewDelegate {
    //MARK: - Properties
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Trending","NowPlaying","Popular","TopRated","Upcoming"]
        let segmented = UISegmentedControl(items: items)
        segmented.selectedSegmentTintColor = .white
        segmented.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)], for: .normal)
        segmented.tintColor = .gray
        segmented.backgroundColor = .darkGray
        segmented.selectedSegmentIndex = 0
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.addTarget(self, action: #selector(selectSection(_:)), for: .valueChanged)
        return segmented
    }()
    
    var presenter: HomeViewOutputProtocol?
    private var moviesModel: [MovieResult]?
    {
        didSet {
            self.movieTableView.reloadData()
        }
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.register(HomeCell.self, forCellReuseIdentifier: CellConstants.cellID)
        let exitButtom: UIBarButtonItem
        exitButtom = UIBarButtonItem(title: LocalizableString.searchTitle.localized,
                                     style: .plain,
                                     target: self,
                                     action: #selector(gotoSerch))
        navigationItem.setRightBarButton(exitButtom,
                                         animated: false)
        title = LocalizableString.labelTitle.localized
        self.view.backgroundColor = UIColor.AppColors.homeBackgroundColor
        addViews()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectSection(segmentedControl)
    }
    
    // MARK: Functions
    @objc public func gotoSerch() {
        let viewController = SearchRouter.createModule()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func addViews() {
        self.view.addSubview(segmentedControl)
        self.view.addSubview(movieTableView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: ConstraintConstants.small),
            segmentedControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: ConstraintConstants.extraSmall),
            segmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -ConstraintConstants.extraSmall),
            segmentedControl.heightAnchor.constraint(equalToConstant: ConstraintConstants.segmentedHeight),
            
            movieTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: ConstraintConstants.small),
            movieTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupViews() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(HomeCell.self, forCellReuseIdentifier: CellConstants.cellID)
    }
    
    @objc func selectSection(_ sender: UISegmentedControl) {
        var selection: Endpoint = .trending
        switch sender.selectedSegmentIndex {
        case 0:
            selection = .trending
            break
        case 1:
            selection = .nowPlaying
            break
        case 2:
            selection = .popular
            break
        case 3:
            selection = .topRated
            break
        case 4:
            selection = .upcoming
            break
        default:
            break
        }
        presenter?.getDataMovies(endPoint: selection)
    }

}

//MARK: - Extensions
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cellID, for: indexPath) as? HomeCell
        else { return UITableViewCell() }
        cell.setupTitle(title: self.moviesModel?[indexPath.row].title ?? "")
        self.presenter?.getMovieImage(index: indexPath.row, completion: { image in
            let imgDefault = UIImage(named: "poster") ?? UIImage()
            cell.setupImage(image: (image ?? imgDefault))
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - P R E S E N T E R · T O · V I E W
extension HomeViewController: HomeViewInputProtocol {
    func showViewDataMovies(movies: [ListMovieProtocol]?) {
        self.moviesModel = movies as? [MovieResult]
    }
}
