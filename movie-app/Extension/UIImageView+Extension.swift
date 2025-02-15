//
//  UIImageView+Extension.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ urlString: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/original/" + urlString)

        let processor = DownsamplingImageProcessor(size: self.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 8)

        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
