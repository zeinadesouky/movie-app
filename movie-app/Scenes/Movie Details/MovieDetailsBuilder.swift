//
//  MovieDetailsBuilder.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation
import UIKit

class MovieDetailsBuilder {
    static func build(with movieId: Int) -> MovieDetailsVC {
        let service = FetchMovieDetailsService()
        let useCase = FetchMovieDetailsUseCaseImp(service: service)
        let viewController = MovieDetailsVC()
        let presenter = MovieDetailsPresenter(view: viewController,
                                              fetchMovieDetailsUseCase: useCase,
                                              movieId: movieId)
        viewController.presenter = presenter
        return viewController
    }
}
