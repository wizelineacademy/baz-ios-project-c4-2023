//
//  SearchTableViewController.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var viewModel: SearchViewModel
    var dataSource: SearchViewModel.MediaTableDataSource?
    var dispatchService: DispatchProtocol = DispatchQueue.main
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search moves, tv series, people..."
        return searchController
    }()

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
        self.title = "Search"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindings()
        setView()
        setSearchController()
        createDataSource()
        loadData()
    }
    
    private func setView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
    }
    
    private func setSearchController() {
        navigationItem.searchController = searchController
    }
    
    private func loadData() {
        viewModel.loadData()
    }
    
    private func bindings() {
        viewModel.bindSnapshot { [weak self] snapshot in
            self?.dispatchService.async {
                self?.dataSource?.apply(snapshot)
            }
        }
    }
    
    private func createDataSource() {
        dataSource = SearchViewModel.MediaTableDataSource(tableView: tableView) { [weak self] (tableView, indexPath, itemIdentifier) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell, let model = self?.viewModel.getCellModel(for: itemIdentifier) else { return UITableViewCell() }
            cell.setCell(with: model)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    private func simpleHeader(title: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .systemBackground
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        return view
    }
}

extension SearchTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        dispatchService.asyncAfter(deadline: .now() + 0.8) {
            if let searchText = searchController.searchBar.text, searchText != "" {
                self.viewModel.searchMedia(keyword: searchText)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadData()
    }
    
}

extension SearchTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * 0.25
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionTitle = viewModel.getSectionTitle(for: section) else { return nil }
        return simpleHeader(title: sectionTitle)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailView = viewModel.getDetailView(for: dataSource?.itemIdentifier(for: indexPath)) else { return }
        navigationController?.pushViewController(detailView, animated: true)
    }
    
}
