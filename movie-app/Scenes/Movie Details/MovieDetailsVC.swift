//
//  MovieDetailsVC.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import UIKit

protocol MovieDetailsView: AnyObject {
    func displayError(_ message: String)
    func display(movieInfo: MovieDetails)
    func setWatchlistButton(for isMovieInList: Bool)
    func loadDetailsView()
    func hideDetailsViewLoader()
}

class MovieDetailsVC: UIViewController, MovieDetailsView {
    
    // Movie Info
    @IBOutlet private weak var movieIcon: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieOverview: UILabel!
    @IBOutlet private weak var movieTagLine: UILabel!
    @IBOutlet private weak var revnue: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var statues: UILabel!
    @IBOutlet private weak var addToWatchlistButton: UIButton!
    // Containers
    @IBOutlet private weak var movieDetailsContainer: UIView!
    @IBOutlet private weak var similarMoviesContainer: UIView!
    @IBOutlet private weak var castAndCrewContainer: UIView!
    
    var presenter: MovieDetailsPresenter!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadMovieDetails()
    }
    
    func display(movieInfo: MovieDetails) {
        movieTitle.text = movieInfo.title ?? "-"
        movieOverview.text = movieInfo.overview ?? "--"
        setWatchlistButton(for: UserUtilities.loadWatchlist().contains(where: {$0 == movieInfo.id}))
        movieIcon.setImage(movieInfo.posterPath ?? "")
        movieTagLine.text = "Tagline: " + (movieInfo.tagline ?? "")
        revnue.text = "Revenue: " + (movieInfo.revenue?.description ?? "") + " USD"
        releaseDate.text = "Release Date: " + (movieInfo.releaseDate ?? "")
        statues.text = "Status: " + (movieInfo.status ?? "")
    }
    
    func setWatchlistButton(for isMovieInList: Bool) {
        addToWatchlistButton.setTitle(isMovieInList ? "Remove From Watchlist" : "Add To Your Watchlist", for: .normal)
        addToWatchlistButton.setImage(isMovieInList ? UIImage(systemName: "minus") : UIImage(systemName: "plus"), for: .normal)
    }

    func displayError(_ message: String) {
        print("Error: \(message)")
    }
    
    func loadDetailsView() {
        movieDetailsContainer.showLoading()
    }
    
    func hideDetailsViewLoader() {
        movieDetailsContainer.hideLoading()
    }
    
    @IBAction func watchListButtonTapped(_ sender: Any) {
        presenter.handleWatchlistOperations()
    }
}
