//
//  MovieListVC.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation
import UIKit

protocol MovieListView: AnyObject {
    func displayError(_ message: String)
    func navigateToMovieDetails(movieId: Int)
    func reloadTableView()
}

class MovieListVC: UIViewController, MovieListView {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: MovieListPresenter!
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        presenter.loadMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // REVIST: reloading results is not the optimal way to reflect watchlist status after changing it within product details
        if presenter.isViewingSearchResults {
            presenter.searchMovies(with: searchBar.text ?? "")
        } else { presenter.resetMovieEntities() }
    }
    
    private func setupSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func displayError(_ message: String) {
        print("Error: \(message)")
    }
    
    func navigateToMovieDetails(movieId: Int) {
        let detailsVC = MovieDetailsBuilder.build(with: movieId)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForSection(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectMovie(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.loadMoreMoviesIfNeeded(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        cell.delegate = self
        presenter.configure(for: cell, at: indexPath)
        return cell
    }
}

extension MovieListVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarCleared()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.searchBarCleared()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchMovies(with: searchBar.text ?? "")
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension MovieListVC: MovieListCellDelegate {
    func didTapAddToWatchlist(_ cell: MovieListCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            presenter.handleWatchlistOperations(at: indexPath, for: cell)
        }
    }
}
