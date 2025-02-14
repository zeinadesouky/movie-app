//
//  MovieListCell.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import UIKit

protocol MovieListCellDelegate: AnyObject {
    func didTapAddToWatchlist(_ cell: MovieListCell)
}

class MovieListCell: UITableViewCell {

    @IBOutlet private weak var movieIcon: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieOverviewLabel: UILabel!
    @IBOutlet private weak var addToWatchlistButton: UIButton!
    
    weak var delegate: MovieListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func display(movieInfo: MovieEntity) {
        movieTitleLabel.text = movieInfo.title ?? "-"
        movieOverviewLabel.text = movieInfo.overview ?? "--"
        setWatchlistButton(for: movieInfo.isInWatchlist ?? false)
        movieIcon.setImage(movieInfo.posterPath ?? "")
    }
    
    func setWatchlistButton(for isMovieInList: Bool) {
        addToWatchlistButton.setTitle(isMovieInList ? "Remove From Watchlist" : "Add To Your Watchlist", for: .normal)
        addToWatchlistButton.setImage(isMovieInList ? UIImage(systemName: "minus") : UIImage(systemName: "plus"), for: .normal)
    }
    
    @IBAction func addToWishlistTapped(_ sender: Any) {
        delegate?.didTapAddToWatchlist(self)
    }
}
