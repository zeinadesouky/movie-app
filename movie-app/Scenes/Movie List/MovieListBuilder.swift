//
//  MovieListBuilder.swift
//  movie-app
//
//  Created by Robusta on 13/02/2025.
//

import Foundation
import UIKit

class MovieListModuleBuilder {
    static func build() -> MovieListVC {
        let fetchService = FetchMoviesService()
        let searchService = SearchMovieService()
        let fetchMoviesUseCase = FetchMoviesUseCaseImp(movieService: fetchService)
        let searchMoviesUseCase = SearchMoviesUseCaseImp(service: searchService)
        let viewController = MovieListVC()
        let presenter = MovieListPresenter(view: viewController,
                                           fetchMoviesUseCase: fetchMoviesUseCase,
                                           searchMoviesUseCase: searchMoviesUseCase)
        viewController.presenter = presenter
        return viewController
    }
}
