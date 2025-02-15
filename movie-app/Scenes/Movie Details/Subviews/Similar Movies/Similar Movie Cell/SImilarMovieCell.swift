//
//  SImilarMovieCell.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import UIKit

class SImilarMovieCell: UICollectionViewCell {

    @IBOutlet private weak var movieIcon: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(movie: Movie) {
        movieIcon.setImage(movie.posterPath ?? "")
        movieTitleLabel.text = movie.title ?? ""
    }

}
